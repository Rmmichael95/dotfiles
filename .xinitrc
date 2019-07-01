#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi
compton &
#nm-applet &

# Default
session=${1:-dwm}

~/Documents/batcave/dotfiles/dwm_status.sh &

case $session in
    i3|i3wm           ) exec $STARTUP i3;;
    awesome	      ) exec $STARTUP awesome;;
    dwm               ) exec $STARTUP dwm;;
    # No known session, try to run it as command
    *                 ) exec $STARTUP $1;;
esac
