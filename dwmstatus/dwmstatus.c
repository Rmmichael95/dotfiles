/*
 * Copy me if you can.
 * by 20h
 */

#define _BSD_SOURCE
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#include <strings.h>
#include <sys/time.h>
#include <time.h>
#include <sys/types.h>
#include <sys/wait.h>

#include <alsa/asoundlib.h>
#include <alsa/control.h>

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mpd/client.h>

#include <X11/Xlib.h>

char *tzlct = "America/Los_Angeles";

static Display *dpy;

char *
smprintf(char *fmt, ...)
{
	va_list fmtargs;
	char *ret;
	int len;

	va_start(fmtargs, fmt);
	len = vsnprintf(NULL, 0, fmt, fmtargs);
	va_end(fmtargs);

	ret = malloc(++len);
	if (ret == NULL) {
		perror("malloc");
		exit(1);
	}

	va_start(fmtargs, fmt);
	vsnprintf(ret, len, fmt, fmtargs);
	va_end(fmtargs);

	return ret;
}

void
settz(char *tzname)
{
	setenv("TZ", tzname, 1);
}

char *
mktimes(char *fmt, char *tzname)
{
	char buf[129];
	time_t tim;
	struct tm *timtm;

	settz(tzname);
	tim = time(NULL);
	timtm = localtime(&tim);
	if (timtm == NULL)
		return smprintf("");

	if (!strftime(buf, sizeof(buf)-1, fmt, timtm)) {
		fprintf(stderr, "strftime == 0\n");
		return smprintf("");
	}

	return smprintf("%s", buf);
}

int
get_vol(void)
{
	int vol;
	snd_hctl_t *hctl;
	snd_ctl_elem_id_t *id;
	snd_ctl_elem_value_t *control;

// To find card and subdevice: /proc/asound/, aplay -L, amixer controls
	snd_hctl_open(&hctl, "default", 0);
	snd_hctl_load(hctl);

	snd_ctl_elem_id_alloca(&id);
	snd_ctl_elem_id_set_interface(id, SND_CTL_ELEM_IFACE_MIXER);

// amixer controls
	snd_ctl_elem_id_set_name(id, "Master Playback Volume");

	snd_hctl_elem_t *elem = snd_hctl_find_elem(hctl, id);

	snd_ctl_elem_value_alloca(&control);
	snd_ctl_elem_value_set_id(control, id);

	snd_hctl_elem_read(elem, control);
	vol = (int)snd_ctl_elem_value_get_integer(control,0);
	vol += 100;
	vol /= 656;

	snd_hctl_close(hctl);
	return vol;
}


/* simple function to retrieve mpd status */
char *
getmpdstat() {
    struct mpd_song * song = NULL;
	const char * title = NULL;
	const char * artist = NULL;
	char * retstr = NULL;
	int elapsed = 0, total = 0;
    struct mpd_connection * conn ;
    if (!(conn = mpd_connection_new("localhost", 0, 30000)) ||
        mpd_connection_get_error(conn)){
            return smprintf("");
    }

    mpd_command_list_begin(conn, true);
    mpd_send_status(conn);
    mpd_send_current_song(conn);
    mpd_command_list_end(conn);

    struct mpd_status* theStatus = mpd_recv_status(conn);
        if ((theStatus) && (mpd_status_get_state(theStatus) == MPD_STATE_PLAY)) {
                mpd_response_next(conn);
                song = mpd_recv_song(conn);
                title = smprintf("%s",mpd_song_get_tag(song, MPD_TAG_TITLE, 0));
                artist = smprintf("%s",mpd_song_get_tag(song, MPD_TAG_ARTIST, 0));

                elapsed = mpd_status_get_elapsed_time(theStatus);
                total = mpd_status_get_total_time(theStatus);
                mpd_song_free(song);
                retstr = smprintf("%.2d:%.2d/%.2d:%.2d %s - %s",
                                elapsed/60, elapsed%60,
                                total/60, total%60,
                                artist, title);
                free((char*)title);
                free((char*)artist);
        }
        else retstr = smprintf("");
		mpd_response_finish(conn);
		mpd_connection_free(conn);
		return retstr;
}
void
setstatus(char *str)
{
	XStoreName(dpy, DefaultRootWindow(dpy), str);
	XSync(dpy, False);
}

char *
loadavg(void)
{
	double avgs[3];

	if (getloadavg(avgs, 3) < 0)
		return smprintf("");

	return smprintf("%.2f %.2f %.2f", avgs[0], avgs[1], avgs[2]);
}

char *
readfile(char *base, char *file)
{
	char *path, line[513];
	FILE *fd;

	memset(line, 0, sizeof(line));

	path = smprintf("%s/%s", base, file);
	fd = fopen(path, "r");
	free(path);
	if (fd == NULL)
		return NULL;

	if (fgets(line, sizeof(line)-1, fd) == NULL)
		return NULL;
	fclose(fd);

	return smprintf("%s", line);
}

char *
getbattery(char *base)
{
	char *co, status;
	int descap, remcap;

	descap = -1;
	remcap = -1;

	co = readfile(base, "present");
	if (co == NULL)
		return smprintf("");
	if (co[0] != '1') {
		free(co);
		return smprintf("not present");
	}
	free(co);

	co = readfile(base, "charge_full_design");
	if (co == NULL) {
		co = readfile(base, "energy_full_design");
		if (co == NULL)
			return smprintf("");
	}
	sscanf(co, "%d", &descap);
	free(co);

	co = readfile(base, "charge_now");
	if (co == NULL) {
		co = readfile(base, "energy_now");
		if (co == NULL)
			return smprintf("");
	}
	sscanf(co, "%d", &remcap);
	free(co);

	co = readfile(base, "status");
	if (!strncmp(co, "Discharging", 11)) {
		status = '-';
	} else if(!strncmp(co, "Charging", 8)) {
		status = '+';
	} else {
		status = '?';
	}

	if (remcap < 0 || descap < 0)
		return smprintf("invalid");

	return smprintf("%.0f%%%c", ((float)remcap / (float)descap) * 100, status);
}

char *
gettemperature(char *base, char *sensor)
{
	char *co;

	co = readfile(base, sensor);
	if (co == NULL)
		return smprintf("");
	return smprintf("%02.0f°C", atof(co) / 1000);
}

int
main(void)
{
	char *status;
	/* char *avgs; */
	char *bat;
	int vol;
	char *mpdcur;
	char *tmlc;
	/* char *t0, *t1, *t2; */
	char systray[] = "       ";
	/* char nompd[] = "                                                                                                                                                               "; */
	/* char yesmpd[] = "                                                                                             "; */

	if (!(dpy = XOpenDisplay(NULL))) {
		fprintf(stderr, "dwmstatus: cannot open display.\n");
		return 1;
	}

	for (;;sleep(1)) {
		/* avgs = loadavg(); */
		/* bat = getbattery("/sys/class/power_supply/BAT0"); */
		vol = get_vol();
		mpdcur = getmpdstat();
		/* tmar = mktimes("%H:%M", tzargentina); */
		/* tmutc = mktimes("%H:%M", tzutc); */
		/* tmlc = mktimes("%a %H:%M", tzlct); */
		/* t0 = gettemperature("/sys/devices/virtual/hwmon/hwmon0", "temp1_input"); */
		/* t1 = gettemperature("/sys/devices/virtual/hwmon/hwmon2", "temp1_input"); */
		/* t2 = gettemperature("/sys/devices/virtual/hwmon/hwmon4", "temp1_input"); */

		status = smprintf("%s %s %d%s %s",
			    mpdcur, "♪", vol, "%", systray);

		/* status = (strncmp(mpdcur, "", 1) == 0)? smprintf("%s %s %s %s %d%s %s", */
		/* 		tmlc, nompd, mpdcur, "♪", vol, "%", systray) : */
		/*     smprintf("%s %s %s %s %d%s %s", */
		/* 		tmlc, yesmpd, mpdcur, "♪", vol, "%", systray); */
		setstatus(status);

		/* free(t0); */
		/* free(t1); */
		/* free(t2); */
		/* free(avgs); */
		/* free(bat); */
		free(mpdcur);
		/* free(tmlc); */
		free(status);
	}

	XCloseDisplay(dpy);

	return 0;
}

