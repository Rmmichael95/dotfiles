#!/usr/bin/env sh

[ -f ~/.xprofile ] && . ~/.xprofile

if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

eval $(ssh-agent)

#xrandr --setprovideroutputsource modesetting NVIDIA-0
#xrandr --auto

case $WM in
    dwm) exec $STARTUP dwm;;
#    dwm) exec dbus-launch --exit-with-session dwm;;
    bspwm) exec $STARTUP bspwm;;
esac
