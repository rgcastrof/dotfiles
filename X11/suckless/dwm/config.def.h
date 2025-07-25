/* See LICENSE file for copyright and license details. */

#include "themes/dark.h"

/* appearance */
static const unsigned int borderpx  = 2;        /* border pixel of windows */
static const unsigned int gappx     = 10;       /* gaps between windows */
static const unsigned int snap      = 15;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const int vertpad            = 7;       /* vertical padding of bar */
static const int sidepad            = 10;       /* horizontal padding of bar */
static const char *fonts[]          = { "JetBrainsMonoNerdFont:size=12" };
static const char dmenufont[]       = "monospace:size=10";
static const char *colors[][3]      = {
        /*               fg         bg         border   */
        [SchemeNorm] = { col_gray2, col_gray1, col_cyan },
        [SchemeSel]  = { col_gray3, col_gray4,  col_gray5  },
        [SchemeTitle]  = { col_gray3, col_gray1,  col_cyan  },
};

/* tagging */
static const char *tags[] = { " ", " ", " ", "󰨞 ", " ", " " };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
    { "feh",         "feh",   NULL,       0,            True,        -1 },
    { "Zathura",     NULL,    NULL,       0,            True,        -1 },
};

/* layout(s) */
static const float mfact     = 0.5; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ " ",      tile },    /* first entry is default */
	{ " ",      NULL },    /* no layout function means floating behavior */
	{ " ",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-l", "11", "-bw", "3", NULL };
static const char *lockcmd[] = { "slock", NULL };
static const char *browsercmd[] = { "brave", NULL };
static const char *explorercmd[] = { "alacritty", "-e", "ranger", NULL };
static const char *termcmd[]  = { "alacritty", "-e", "tmux", NULL };


static const Key keys[] = {
    /* modifier                     key        function        argument */
    { MODKEY,                       XK_space,  spawn,          {.v = dmenucmd } },
    { MODKEY,                       XK_t,      spawn,          {.v = termcmd } },
    { MODKEY|ControlMask,           XK_l,      spawn,          {.v = lockcmd } },
    { MODKEY,                       XK_b,      spawn,          {.v = browsercmd }},
    { MODKEY,                       XK_e,      spawn,          {.v = explorercmd }},
    { 0,                            XF86XK_AudioRaiseVolume,     spawn,          SHCMD("~/.config/dwm/scripts/volume_up.sh && ~/.config/dwm/scripts/notify_volume_up.sh") },
    { 0,                            XF86XK_AudioLowerVolume,     spawn,          SHCMD("~/.config/dwm/scripts/volume_down.sh && ~/.config/dwm/scripts/notify_volume_down.sh") },
    { 0,                            XF86XK_AudioMute,     spawn,          SHCMD("~/.config/dwm/scripts/toggle_volume.sh") },
    { 0,                            XF86XK_MonBrightnessUp,     spawn,          SHCMD("~/.config/dwm/scripts/bright_up.sh") },
    { 0,                            XF86XK_MonBrightnessDown,     spawn,          SHCMD("~/.config/dwm/scripts/bright_down.sh") },
    { 0,                            XK_Print,  spawn,          SHCMD("~/.config/dwm/scripts/screenshot.sh") },
    { ShiftMask,                    XK_Print,  spawn,          SHCMD("~/.config/dwm/scripts/fullscreenshot.sh") },
    { MODKEY,                       XK_x,      spawn,          SHCMD("~/.config/dwm/scripts/power_menu.sh") },
    { MODKEY,                       XK_w,      spawn,          SHCMD("~/.config/dwm/scripts/wallpaper_picker.sh") },
    { MODKEY|ShiftMask,             XK_m,      spawn,          SHCMD("~/.config/dwm/scripts/play_music.sh") },
	{ MODKEY|ControlMask,           XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY,                       XK_q,      killclient,     {0} },
	{ MODKEY,                       XK_n,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY|ControlMask,           XK_space,  setlayout,      {0} },
	{ MODKEY,                       XK_g,      togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY|ShiftMask,         Button1,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
