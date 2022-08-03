if [ "$WM" = "sway" || "$WM" = dwl ]; then
    if [ -z "${DISPLAY}" ] && [ "$(tty)" = "/dev/tty1" ]; then
        sh $HOME/documents/batcave/dotfiles/start-wayland
    fi
else
    if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
        sh $HOME/documents/batcave/dotfiles/sxrcsession-helper
    fi
fi
