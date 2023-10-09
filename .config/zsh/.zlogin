#echo "/zsh/zlogin"

if [ "$DS" = "w" ]; then
    if [ -z "${DISPLAY}" ] && [ "$(tty)" = "/dev/tty1" ]; then
        #sh $HOME/documents/batcave/dotfiles/start-wayland
        dbus-run-session $WM
    fi
else
    if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
         $HOME/documents/batcave/dotfiles/sxrcsession-helper
    fi
fi
