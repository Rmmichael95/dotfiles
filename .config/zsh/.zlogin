if [ "$WM" = "sway" ]; then
	if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
		XKB_DEFAULT_LAYOUT=us exec sway
	fi
else
	if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
        exec sx $HOME/.config/x11/xinitrc
	fi
fi
