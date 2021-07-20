# PATH
typeset -U PATH path
path=("$PATH" "/usr/local/sbin/" "/usr/local/bin/" "/usr/sbin/" "/usr/bin/" "/sbin/" "/bin/" "/usr/lib/ccache/bin/" "$HOME/.local/bin/" "$HOME/Documents/Notes/" "$HOME/.local/bin/statusbar/" "$HOME/.local/share/skim/bin/" "$path[@]")
export PATH
# MANPATH
export MANPATH="$MANPATH:/usr/local/man:"

# You may need to manually set your language environment
export LANG="en_US.UTF-8"
export LC_COLLATE=C

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
export SHELL=/usr/bin/zsh
export PAGER=less
export TERMINAL=alacritty
export BROWSER=librewolf
export BROWSERCLI=w3m
export READER=zathura
export IMAGEVIEWER=sxiv
export VIDEOPLAYER=mpv
export FILE=cfiles
export COLORTERM="truecolor"
export OPENER="xdg-open"
export GPG_TTY=$(tty)
export QT_QPA_PLATFORMTHEME="qt5ct"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# Other XDG paths
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}
export XDG_STATE_HOME=${XDG_STATE_HOME:="$HOME/.local/state"}

#needs user-authority-in-system-dir=true in lightdm.conf, pam-systemd starts rtd
#export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority

export RBENV_ROOT="$XDG_DATA_HOME"/ruby/rbenv
#if not using rbenv
#export GEM_PATH="$XDG_DATA_HOME/ruby/gems"
#export GEM_SPEC_CACHE="$XDG_DATA_HOME/ruby/specs"
#export GEM_HOME="$XDG_DATA_HOME/ruby/gems"

# ~/ Clean-up: Fixing Paths
export XINITRC="$XDG_CONFIG_HOME"/x11/xinitrc
export XSERVERRC="$XDG_CONFIG_HOME"/x11/xserverrc
export MAKEPKG_CONF="$XDG_CONFIG_HOME/pacman/makepkg.conf"
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export NVM_DIR="$XDG_DATA_HOME"/nvm
export GOPATH="$XDG_DATA_HOME"/go
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export ZDOTDIR=$XDG_CONFIG_HOME/zsh
export HISTFILE="$XDG_STATE_HOME"/zsh/history
export CARGO_HOME="$XDG_DATA_HOME"/cargo
#export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME"/ripgrep/ripgreprc
#export WINEPREFIX="$XDG_DATA_HOME"/wineprefixes/default
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
export NOTMUCH_CONFIG="$XDG_CONFIG_HOME/notmuch-config"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="-"
export INPUTRC="$XDG_CONFIG_HOME/shell/inputrc"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/share/password-store"
export GNUPGHOME="$XDG_DATA_HOME"/gnupg

# Other program settings:
export DICS="/usr/share/stardict/dic/"
export SUDO_ASKPASS="$XDG_DATA_HOME/bin/dmenupass"
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
