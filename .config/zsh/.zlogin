if [ "$DS" = "w" ]; then
    if [ -z "${DISPLAY}" ] && [ "$(tty)" = "/dev/tty1" ]; then
        if uwsm check may-start; then
            exec uwsm start $WM
        else
            dbus-run-session $WM
        fi
        #/usr/lib/plasma-dbus-run-session-if-needed && /usr/bin/startplasma-wayland
    fi
 else
     if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
          $HOME/documents/batcave/dotfiles/sxrcsession-helper
     fi
 fi
