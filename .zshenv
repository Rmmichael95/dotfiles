# PATH
typeset -U PATH path
path=("$PATH" "/usr/local/sbin" "/usr/local/bin/" "/usr/sbin/" "/usr/bin" "/sbin" "/bin" "/usr/lib/ccache/bin/" "$HOME/.local/bin" "$HOME/Documents/Notes/" "$path[@]")
export PATH
# MANPATH
export MANPATH="$MANPATH:/usr/local/man:"

# You may need to manually set your language environment
export LANG=en_US.UTF-8
# Compilation flags
export ARCHFLAGS="-arch x86_64"
# makeflags
export MAKEFLAGS="-j9 -l8"

# Default programs:
# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR="vim"
else
  export EDITOR="nvim"
fi
export SHELL=/bin/zsh
export PAGER=less
export TERM=alacritty
export BROWSER=brave
export BROWSERCLI=w3m
export READER=zathura
export IMAGEVIEWER=sxiv
export VIDEOPLAYER=mpv
export FILE=cfiles
export GPG_TTY=$(tty)
export QT_QPA_PLATFORMTHEME="qt5ct"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# ~/ Clean-up:
export NOTMUCH_CONFIG="$HOME/.config/notmuch-config"
export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="-"
export INPUTRC="$HOME/.config/shell/inputrc"
export ZDOTDIR="$HOME/.config/zsh"
export PASSWORD_STORE_DIR="$HOME/.local/share/password-store"
export GNUPGHOME DEFAULT="$HOME/.local/share/.gnupg"

# Other program settings:
export DICS="/usr/share/stardict/dic/"
export SUDO_ASKPASS="$HOME/.local/bin/dmenupass"
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"
export LESS=-R
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"
export LESS_TERMCAP_me="$(printf '%b' '[0m')"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"
export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"
export PAGER="${commands[less]:-$PAGER}"  \
  _NROFF_U=1 \
  PATH="$HOME/bin:$PATH" \
    "$@"
