/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const unsigned int systraypinning = 0;   /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayspacing = 2;   /* systray spacing */
static const int systraypinningfailfirst = 1;   /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static const int showsystray        = 1;     /* 0 means no systray */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char buttonbar[]       = "<0>";
static const char *fonts[]          = { "cherry:style=Regular:size=14" };
static const char dmenufont[]       = "cherry:style=Regular:size=14";
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#3A4B52";
static const char col_black[]       = "#000000";
static const char col_red[]         = "#ff0000";
static const char col_yellow[]      = "#ffff00";
static const char col_white[]       = "#ffffff";

static const char *colors[][3]      = {
	/*					fg         bg          border   */
	[SchemeNorm] =	 { col_gray3, col_gray1,  col_gray3 },
	[SchemeSel]  =	 { col_gray4, col_cyan,   col_cyan   },
	[SchemeWarn] =	 { col_black, col_yellow, col_red },
	[SchemeUrgent]=	 { col_white, col_red,    col_red},
};

/* tagging */
static const char *tags[] = { "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp"   ,     NULL,       NULL,       0,            1,           -1 },
	{ "qutebrowser", NULL,       NULL,       0 << 1,       0,           -1 },
	{ "palemoon"  ,  NULL,       NULL,       1 << 8,       0,           -1 },
	{ "zathura"   ,  NULL,       NULL,       1 << 4,       0,           -1 },
	{ "neomutt"   ,  NULL,       NULL,       1 << 7,       0,           -1 },
	{ "newsboat"  ,  NULL,       NULL,       1 << 8,       0,           -1 },
	{ "discord"    , NULL,       NULL,       1 << 5,       0,           -1 },

};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
/* Mod4Mask == Super key
 * Mod1Mask == Alt key
 * Mod5Mask == Alt Gr
 */
#define MODKEY Mod4Mask
#define XF86PowerOff 0x1008ff2a
#define XF86AudioRaiseVolume 0x1008ff13
#define XF86AudioLowerVolume 0x1008ff11
#define XF86AudioMute 0x1008ff12
#define XF86MonBrightnessUp 0x1008ff05
#define XF86MonBrightnessDown 0x1008ff06
#define XF86AudioPrev 0x1008ff16
#define XF86AudioStop 0x1008ff15
#define XF86AudioPlay 0x1008ff14
#define XF86AudioNext 0x1008ff17
#define XF86Explorer 0x1008ff5d
#define XF86HomePage 0x1008ff18
#define XF86Mail 0x1008ff19
#define XF86Calculator 0x1008ff1d
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      comboview,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      combotag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
/* static const char *fzfcmd[] = { "fzf_dmenu", "fzf_cmd", "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL }; */
static const char *termcmd[]  = { "st", NULL };
static const char *cmdpower[] = {"dmenu_power", "Do you want to poweroff?", "poweroff", "reboot", NULL};
static const char *cmdinfo[] = { "sysinfo", NULL };
static const char *cmdsoundup[]  = { "amixer", "-q", "sset", "Master", "1%+", NULL };
static const char *cmdsounddown[]  = { "amixer", "-q", "sset", "Master", "1%-", NULL };
static const char *cmdsoundtoggle[]  = { "amixer", "-q", "sset", "Master", "toggle", NULL };
static const char *cmdbrightnessup[]  = { "sudo", "brightness", "up", NULL  };
static const char *cmdbrightnessdown[]  = { "sudo", "brightness", "down", NULL  };
static const char *cmdmail[]       = { "st", "-c", "neomutt", "-e", "neomutt", NULL};
static const char *cmdnewsboat[] = { "st", "-c", "newsboat", "-e", "newsboat", NULL };
/* static const char *cmdlock[]       = { "amixer", "-q", "sset", "Master", "mute", "&&", "locki3.sh", NULL}; */

#include "mpdcontrol.c"

static Key keys[] = {
	/* modifier                     key        function        argument */
	{ 0,                            XF86AudioRaiseVolume, spawn,         {.v = cmdsoundup } },
	{ 0,                            XF86AudioLowerVolume, spawn,         {.v = cmdsounddown } },
	{ 0,                            XF86AudioMute,        spawn,         {.v = cmdsoundtoggle } },
	{ 0,                            XF86MonBrightnessUp,  spawn,         {.v = cmdbrightnessup } },
	{ 0,                            XF86MonBrightnessDown,spawn,         {.v = cmdbrightnessdown } },
	{ 0,                            XF86AudioPrev,        mpdchange,     {.i = -1} },
	{ 0,                            XF86AudioNext,        mpdchange,     {.i = +1} },
	{ 0,                            XF86AudioStop,        mpdcontrol,    {.i = -1} },
	{ 0,                            XF86AudioPlay,        mpdcontrol,    {.i = +1} },
	{ 0,                            XF86Mail,             spawn,         {.v = cmdmail } },
	{ MODKEY,                       XK_n,                 spawn,         {.v = cmdnewsboat } },
	{ MODKEY,                       XK_r,                 spawn,         {.v = dmenucmd } },
	{ MODKEY,                       XK_Return,            spawn,         {.v = termcmd } },
	{ MODKEY,                       XK_b,                 togglebar,     {0} },
	{ MODKEY,                       XK_j,                 focusstack,    {.i = +1 } },
	{ MODKEY,                       XK_k,                 focusstack,    {.i = -1 } },
	{ MODKEY,                       XK_i,                 incnmaster,    {.i = +1 } },
	{ MODKEY,                       XK_d,                 incnmaster,    {.i = -1 } },
	{ MODKEY,                       XK_h,                 setmfact,      {.f = -0.05} },
	{ MODKEY,                       XK_l,                 setmfact,      {.f = +0.05} },
	{ MODKEY|ShiftMask,             XK_Return,            zoom,          {0} },
	{ MODKEY,                       XK_Tab,               view,          {0} },
	{ MODKEY|ShiftMask,             XK_x,                 killclient,    {0} },
	{ MODKEY,                       XK_t,                 setlayout,     {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,                 setlayout,     {.v = &layouts[1]} },
	{ MODKEY|ShiftMask,             XK_m,                 setlayout,     {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,             setlayout,     {0} },
	{ MODKEY|ShiftMask,             XK_space,             togglefloating,{0} },
	{ MODKEY,                       XK_0,                 view,          {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,                 tag,           {.ui = ~0 } },
	{ MODKEY,                       XK_comma,             focusmon,      {.i = -1 } },
	{ MODKEY,                       XK_period,            focusmon,      {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,             tagmon,        {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period,            tagmon,        {.i = +1 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_z,                 dmenu_logout,  {0} },
	{ 0,                            XF86PowerOff,         spawn,         {.v = cmdpower } },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkButton, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkButton,            0,              Button1,        spawn,          {.v = cmdinfo } },
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

