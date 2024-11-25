# PATH
#typeset -U PATH path
#path=("$PATH" "/usr/local/sbin/" "/usr/local/bin/" "/usr/sbin/" "/usr/bin/" "/sbin/" "/bin/" "/usr/lib/ccache/bin/" "$HOME/.local/bin/" "$HOME/Documents/Notes/" "$HOME/.local/bin/statusbar/" "$HOME/.local/share/skim/bin/" "$path[@]")
export PATH="$PATH:/usr/local/sbin/:/usr/local/bin/:/usr/sbin/:/usr/bin/:/sbin/:/bin/:/usr/lib/ccache/bin/:$HOME/.local/bin/:$HOME/.local/share/npm/bin/:$HOME/.local/bin/myBin/:$HOME/.local/bin/myBin/doas/:$HOME/.local/bin/myBin/menu/:$HOME/.local/bin/myBin/hypr:$HOME/.config/composer/vendor/bin/:$HOME/.nix-profile/bin/"
export PATH
# MANPATH
export MANPATH="$MANPATH:/usr/local/man:"
# CDPATH
#export CDPATH="$CDPATH:.:$HOME/documents/batcave"

# You may need to manually set your language environment
export LANG="en_US.UTF-8"
#export LC_COLLATE="C"
#export LC_ALL=C

#ds
export DS="$(cat /home/ryanm/.local/share/ds 2>/dev/null)"
#wm
export WM="$(cat /home/ryanm/.local/share/wm 2>/dev/null)"

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# makeflags
export MAKEFLAGS="-j$(nproc)"

# Default programs:
# Preferred editor for local and remote sessions
#if [ -n $SSH_CONNECTION ]; then
#  export EDITOR="vim"
#else
  export EDITOR="nvim"
#fi
export SHELL=/usr/bin/zsh
export PAGER='nvim +Man!'
export MANPAGER='nvim +Man!'
export TERMINAL=alacritty
export BROWSER=floorp
export BROWSERCLI=w3m
export READER=zathura
export IMAGEVIEWER=nsxiv
export VIDEOPLAYER=mpv
export FILE=lf
export COLORTERM="truecolor"
export OPENER="xdg-open"
export GPG_TTY=$(tty)
export QT_QPA_PLATFORMTHEME="qt5ct"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export WINEFSYNC=1
#export LIBVA_DRIVER_NAME="radeonsi"
export NOTES_DIR="$HOME/documents/batcave/notes"
export MAILSYNC_MUTE=1

# Other XDG paths
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}
export XDG_STATE_HOME=${XDG_STATE_HOME:="$HOME/.local/state"}
export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:="run/user/$UID"}

# nvidia
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv

# git
# export GITCONFIG="$XDG_CONFIG_HOME"/git/config
# export GITIGNORE="$XDG_CONFIG_HOME"/git/ignore
# export GITATTRIBUTES="$XDG_CONFIG_HOME"/git/attributes
# export GIT-CREDENTIALS="$XDG_CONFIG_HOME"/git/credentials
# export GITK="$XDG_CONFIG_HOME"/git/gitk

# XDG_CONFIG_HOME/git/config
# XDG_CONFIG_HOME/git/ignore
# XDG_CONFIG_HOME/git/attributes
# XDG_CONFIG_HOME/git/credentials
# XDG_CONFIG_HOME/git/gitk

# latex
export TEXMFVAR=$XDG_CACHE_HOME/texlive/texmf-var
export TEXMFCONFIG=$XDG_CONFIG_HOME/texlive/texmf-config

# gdb
#XDG_CONFIG_HOME/gdb/gdbinit
export GDBHISTFILE="$XDG_DATA_HOME"/gdb/history

#startx
#export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
#sx
#export XAUTHORITY="$XDG_DATA_HOME"/sx/xauthority

#doesnt seem to work with dxvk; got working
export WINEPREFIX="$XDG_DATA_HOME"/wineprefixes/default

export RBENV_ROOT="$XDG_DATA_HOME"/rbenv
#if not using rbenv
#export GEM_PATH="$XDG_DATA_HOME/ruby/gems"
#export GEM_SPEC_CACHE="$XDG_DATA_HOME/ruby/specs"
#export GEM_HOME="$XDG_DATA_HOME/ruby/gems"

export PYTHONSTARTUP="/etc/python/pythonrc"

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
#export ZDOTDIR=$XDG_CONFIG_HOME/zsh
export HISTFILE="$XDG_STATE_HOME"/zsh/history
export PYTHONHISTFILE="$XDG_STATE_HOME"/python/history
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME"/ripgrep/ripgreprc
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
export NOTMUCH_CONFIG="$XDG_CONFIG_HOME/notmuch-config"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="-"
export INPUTRC="$XDG_CONFIG_HOME/shell/inputrc"
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/share/password-store"
export GNUPGHOME="$XDG_DATA_HOME"/gnupg

# Other program settings:
export DICS="/usr/share/stardict/dic/"
export SUDO_ASKPASS="$XDG_DATA_HOME/bin/myBin/menu/dmenupass"
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"
#export LESS=-R
#export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"
#export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"
#export LESS_TERMCAP_me="$(printf '%b' '[0m')"
#export LESS_TERMCAP_se="$(printf '%b' '[0m')"
#export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"
#export LESS_TERMCAP_ue="$(printf '%b' '[0m')"
#export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"
#export PAGER="${commands[less]:-$PAGER}"  \
#  _NROFF_U=1 \
#  PATH="$HOME/bin:$PATH" \
#    "$@"

GPG_TTY=$(tty)
export GPG_TTY

#doas-askpass
export DOAS_ASKPASS="dmenu -b -P -p password:"

# ssh-agent
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# gpg-agent as ssh-agent
#export SSH_AGENT_PID=""
#unset SSH_AGENT_PIDexport SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh"

export WINEFSYNC=1

export MBSYNCRC="$XDG_CONFIG_HOME"/isync/mbsyncrc

export XCURSOR_PATH=${XCURSOR_PATH}:~/.local/share/icons
export GTK_THEME=Numix:dark
export XCURSOR_THEME=Numix-Cursor-Light
export XCURSOR_SIZE=28px
#export QT_QPA_PLATFORMTHEME=gtk2

export XDG_DATA_DIRS=$HOME/.nix-profile/share:$XDG_DATA_DIRS

export CHROME_PATH="/usr/bin/brave"

export NIXPKGS_ALLOW_UNFREE=1

export LIBSEAT_BACKEND="logind"
