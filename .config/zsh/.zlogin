if [ -z "${DISPLAY}" ] && [ "$(tty)" = "/dev/tty1" ]; then
    export XDG_DATA_DIRS="/usr/local/share:/usr/share:${XDG_DATA_DIRS}"
    if uwsm check may-start && uwsm select; then
        exec systemd-cat -t uwsm_start uwsm start hyprland-uwsm.desktop
    fi
fi
