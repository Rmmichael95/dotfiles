#!/bin/sh

# Usage:
# `$0`: Ask for recording type via dmenu
# `$0 screencast`: Record both audio and screen
# `$0 video`: Record only screen
# `$0 audio`: Record only audio
# `$0 kill`: Kill existing recording
#
# If there is already a running instance, user will be prompted to end it.

updateicon() {
	echo "$1" > /tmp/recordingicon
	pkill -RTMIN+9 "${STATUSBAR:-dwmblocks}"
}

killrecording() {
	recpid="$(cat /tmp/recordingpid)"
	# kill with SIGTERM, allowing finishing touches.
	kill -15 "$recpid"
	rm -f /tmp/recordingpid
	updateicon ""
	pkill -RTMIN+9 "${STATUSBAR:-dwmblocks}"
	# even after SIGTERM, ffmpeg may still run, so SIGKILL it.
	sleep 3
	kill -9 "$recpid"
	exit
}

screencast_alsa() {
	ffmpeg -y -probesize 42M \
	-threads:v 1 -threads:a 1 -filter_threads 1 \
	-hwaccel vaapi \
	-vaapi_device /dev/dri/renderD128 \
	-hwaccel_output_format vaapi \
	-f x11grab -thread_queue_size 512 \
	-video_size "$(xdpyinfo | grep dimensions | awk '{print $2;}')" \
	-framerate 60 \
	-i $DISPLAY \
	-f alsa -thread_queue_size 512 \
	-i sysdefault:CARD=Generic_1 \
	-c:a aac -ac 2 \
	-vf 'format=nv12,hwupload' \
	-vcodec hevc_vaapi \
	"$HOME/videos/screencast-$(date '+%y%m%d-%H%M-%S').mp4" &
	echo $! > /tmp/recordingpid
	updateicon "⏺️🎙️"
}

screencast_pulse() {
	ffmpeg -y -probesize 42M \
	-threads:v 1 -threads:a 1 -filter_threads 1 \
	-hwaccel vaapi \
	-vaapi_device /dev/dri/renderD128 \
	-hwaccel_output_format vaapi \
	-f x11grab -thread_queue_size 512 \
	-video_size "$(xdpyinfo | grep dimensions | awk '{print $2;}')" \
	-framerate 60 \
	-i $DISPLAY \
	-f pulse -thread_queue_size 512 \
	-i default \
	-c:a aac -ac 2 \
	-vf 'format=nv12,hwupload' \
	-vcodec hevc_vaapi \
	"$HOME/videos/screencast-$(date '+%y%m%d-%H%M-%S').mp4" &
	echo $! > /tmp/recordingpid
	updateicon "⏺️🎙️"
}

overlay_alsa() {
	ffmpeg -y -probesize 42M \
	-threads:v 1 -threads:a 1 -filter_threads 1 \
	-hwaccel vaapi \
	-vaapi_device /dev/dri/renderD128 \
	-hwaccel_output_format vaapi \
	-f x11grab -thread_queue_size 512 \
	-video_size "$(xdpyinfo | grep dimensions | awk '{print $2;}')" \
	-r 60 \
	-i $DISPLAY \
	-f v4l2 -thread_queue_size 512 \
	-s 320x240 \
	-r 30 \
	-i /dev/video0 \
	-f alsa -thread_queue_size 512 \
	-i default \
	-c:a aac -ac 2 \
	-filter_complex 'overlay=main_w-overlay_w:main_h-overlay_h:format=yuv422,format=nv12,hwupload' \
	-c:v hevc_vaapi output.mp4
}

overlay_pulse() {
	ffmpeg -y -probesize 42M \
	-threads:v 2 -threads:a 2 -filter_threads 2 \
	-hwaccel vaapi \
	-vaapi_device /dev/dri/renderD128 \
	-hwaccel_output_format vaapi \
	-f x11grab -thread_queue_size 512 \
	-video_size "$(xdpyinfo | grep dimensions | awk '{print $2;}')" \
	-r 60 \
	-i $DISPLAY \
	-f v4l2 -thread_queue_size 512
	-s 320x240 \
	-r 30 \
	-i /dev/video0 \
	-f pulse -thread_queue_size 512 \
	-i default \
	-c:a aac -ac 2 \
	-filter_complex 'overlay=main_w-overlay_w:main_h-overlay_h:format=yuv422,format=nv12,hwupload' \
	-c:v hevc_vaapi output.mp4
}

stream_youtube() {
	DRI_PRIME=1 LIBVA_DRIVER_NAME=radeonsi ffmpeg \
	-threads:v 1 -threads:a 1 -filter_threads 1 \
	-hwaccel vaapi \
	-vaapi_device /dev/dri/renderD128 \
	-hwaccel_output_format vaapi \
	-f x11grab \
	-video_size "$(xdpyinfo | grep dimensions | awk '{print $2;}')" \
	-framerate 60 \
	-thread_queue_size 512 -i $DISPLAY \
	-f alsa -thread_queue_size 512 -i sysdefault:CARD=Generic_1 \
	-c:a aac -ac 2 -b:a 128k \
	-vf 'format=yuv420p,hwupload' \
	-b:v 6000k -minrate 6000k -maxrate 6000k -bufsize:v 6000k \
	-c:v hevc_vaapi -qp:v 19 \
	-profile:v high -rc:v cbr_ld_hq -level:v 4.2 -r:v 60  -g:v 120 -bf:v 0 -refs:v 16 \
	-f flv rtmp://a.rtmp.youtube.com/live2/<stream-key> \
	echo $! > /tmp/recordingpid
	updateicon "⏺️🎙️"
}

tstream_youtube() {
	DRI_PRIME=1 LIBVA_DRIVER_NAME=radeonsi ffmpeg \
	-threads:v 2 -threads:a 2 -filter_threads 2 \
	-hwaccel vaapi \
	-vaapi_device /dev/dri/renderD128 \
	-hwaccel_output_format vaapi \
	1024 -f x11grab \
	-video_size "$(xdpyinfo | grep dimensions | awk '{print $2;}')" \
	-framerate 60 \
	-thread_queue_size 1024 -i $DISPLAY \
	-f pulse -ac 2 -i default \
	-c:a aac -bsf:a hevc_mp4toannexb -ac 2 -b:a 128k \
	-vf 'format=nv12,hwupload' \
	-b:v 2400k -minrate 6000k -maxrate 6000k -bufsize:v 6000k \
	-c:v hevc_vaapi -qp:v 18 \
	-profile:v high -rc:v cbr_ld_hq -level:v 4.2 -r:v 60  -g:v 120 -bf:v 0 -refs:v 16 \
	-f flv rtmp://a.rtmp.youtube.com/live2/<stream-key> \
	echo $! > /tmp/recordingpid
	updateicon "⏺️🎙️"
}

stream_twitch() {
	DRI_PRIME=1 LIBVA_DRIVER_NAME=radeonsi ffmpeg \
	-threads:v 2 -threads:a 2 -filter_threads 2 \
	-hwaccel vaapi \
	-vaapi_device /dev/dri/renderD128 \
	-hwaccel_output_format vaapi \
	-f x11grab \
	-video_size "$(xdpyinfo | grep dimensions | awk '{print $2;}')" \
	-framerate 60 \
	-thread_queue_size 1024 -i $DISPLAY \
	-f alsa -i sysdefault:CARD=Generic_1 \
	-c:a aac -bsf:a hevc_mp4toannexb -ac 2 -b:a 128k \
	-vf 'format=nv12,hwupload' \
	-b:v 2400k -minrate 2400k -maxrate 2400k -bufsize:v 2400k \
	-c:v hevc_vaapi -qp:v 19 \
	-profile:v high -rc:v cbr_ld_hq -level:v 4.2 -r:v 60  -g:v 120 -bf:v 0 -refs:v 16 \
	-f flv rtmp://live.twitch.tv/app/<stream-key> \
	echo $! > /tmp/recordingpid
	updateicon "⏺️🎙️"
}

tstream_twitch() {
	DRI_PRIME=1 LIBVA_DRIVER_NAME=radeonsi ffmpeg \
	-threads:v 2 -threads:a 2 -filter_threads 2 \
	-hwaccel vaapi \
	-vaapi_device /dev/dri/renderD128 \
	-hwaccel_output_format vaapi \
	-f x11grab \
	-video_size "$(xdpyinfo | grep dimensions | awk '{print $2;}')" \
	-framerate 60 \
	-thread_queue_size 1024 -i $DISPLAY \
	-f pulse -ac 2 -i default \
	-c:a aac -bsf:a hevc_mp4toannexb -ac 2 -b:a 128k \
	-vf 'format=nv12,hwupload' \
	-b:v 6000k -minrate 6000k -maxrate 6000k -bufsize:v 6000k \
	-c:v hevc_vaapi -qp:v 18 \
	-profile:v high -rc:v cbr_ld_hq -level:v 4.2 -r:v 60  -g:v 120 -bf:v 0 -refs:v 16 \
	-f flv rtmp://live.twitch.tv/app/<stream-key> \
	echo $! > /tmp/recordingpid
	updateicon "⏺️🎙️"
}

video() {
	DRI_PRIME=1 LIBVA_DRIVER_NAME=radeonsi ffmpeg \
	-threads 4 \
	-hwaccel vaapi \
	-vaapi_device /dev/dri/renderD128 \
	-hwaccel_output_format vaapi \
	-f x11grab  \
	-video_size "$(xdpyinfo | grep dimensions | awk '{print $2;}')" \
	-framerate 60 -probesize 42M \
	-thread_queue_size 1024 -i $DISPLAY \
	-b:v 2400k -minrate 6000k -maxrate 6000k -bufsize 6000k \
	-vf 'format=nv12,hwupload' \
	-vcodec hevc_vaapi -qp 0 -r 30 -g 120 -bf 0 \
	"$HOME/videos/video-$(date '+%y%m%d-%H%M-%S').mkv" &
	echo $! > /tmp/recordingpid
	updateicon "⏺️"
}

webcamhidef() {
    ffmpeg \
	-f v4l2 \
	-i /dev/video0 \
	-video_size 1920x1080 \
	"$HOME/webcam-$(date '+%y%m%d-%H%M-%S').mkv" &
	echo $! > /tmp/recordingpid
	updateicon "🎥"
}

webcam() {
    ffmpeg \
	-f v4l2 \
	-i /dev/video0 \
	-video_size 640x480 \
	"$HOME/webcam-$(date '+%y%m%d-%H%M-%S').mkv" &
	echo $! > /tmp/recordingpid
	updateicon "🎥"
}


audio() {
	ffmpeg \
    -threads 2 \
	-thread_queue_size 1024k \
    -f alsa -i sysdefault:CARD=Generic_1 \
	-c:a flac \
	"$HOME/audio-$(date '+%y%m%d-%H%M-%S').flac" &
	echo $! > /tmp/recordingpid
	updateicon "🎙️"
}

taudio() {
	ffmpeg \
	-threads 4 \
	--thread_queue_size 1024k -f pulse -i default \
	-c:a flac \
	"$HOME/audio-$(date '+%y%m%d-%H%M-%S').flac" &
	echo $! > /tmp/recordingpid
	updateicon "🎙️"
}


askrecording() {
	choice=$(printf "screencast\\nvideo\\nvideo selected\\naudio\\nwebcam\\nwebcam (hi-def)" | dmenu -i -p "Select recording style:")
	case "$choice" in
		screencast) screencast;;
		streamt) twitch;;
		streamy) youtube;;
		audio) audio;;
		video) video;;
		*selected) videoselected;;
		webcam) webcam;;
		"webcam (hi-def)") webcamhidef;;
	esac
}

asktoend() {
	response=$(printf "No\\nYes" | dmenu -i -p "Recording still active. End recording?") &&
	[ "$response" = "Yes" ] &&  killrecording
}

videoselected()
{
	slop -f "%x %y %w %h" > /tmp/slop
	read -r X Y W H < /tmp/slop
	rm /tmp/slop

	ffmpeg \
	-f x11grab \
	-framerate 60 \
	-video_size "$W"x"$H" \
	-i :0.0+"$X,$Y" \
	-c:v libx264 -qp 0 -r 30 \
	"$HOME/box-$(date '+%y%m%d-%H%M-%S').mkv" &
	echo $! > /tmp/recordingpid
	updateicon "⏺️"
}

case "$1" in
	screencast) screencast;;
	streamt) twitch;;
	streamy) youtube;;
	audio) audio;;
	video) video;;
	*selected) videoselected;;
	kill) killrecording;;
	*) ([ -f /tmp/recordingpid ] && asktoend && exit) || askrecording;;
esac
