#
#~/.zprofile
#

[[ -f ~/.zshrc ]] && . ~/.zshrc

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
  XKB_DEFAULT_LAYOUT=us exec sway
else
  startx
fi
