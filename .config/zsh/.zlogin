# Get default WM from ~/.local/share/wm
export WM="$(cat ~/.local/share/wm 2>/dev/null)" &&
	[ "$WM" = "dwm" ] || export WM="bspwm"

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]] && [[ $WM = "sway" ]]; then
  XKB_DEFAULT_LAYOUT=us exec sway
else
  startx
fi
