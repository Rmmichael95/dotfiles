#!/usr/bin/env sh

[ -f ~/.xprofile ] && . ~/.xprofile

if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

case $WM in
    dwm) exec $STARTUP dwm;;
    bspwm) exec $STARTUP bspwm;;
esac
