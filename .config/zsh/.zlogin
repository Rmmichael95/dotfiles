if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]] && [[ ! -z ~/.local/share/wm ]]; then
  XKB_DEFAULT_LAYOUT=us exec sway
else
  startx
fi
