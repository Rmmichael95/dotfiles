# Load aliases and shortcuts if existent.
#[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc"
#[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit

# Include hidden files in autocomplete:
_comp_options+=(globdots)

# Load all of the config files in ~/oh-my-zsh that end in .zsh
# TIP: Add files you don't want in git to .gitignore
for config_file ($HOME/.config/zsh/lib/*.zsh); do
  custom_config_file="${ZSH_CUSTOM}/lib/${config_file:t}"
  [ -f "${custom_config_file}" ] && config_file=${custom_config_file}
  source $config_file
done
source ~/.config/zsh/themes/ys.zsh-theme
source ~/.config/zsh/plugins/tmux/tmux.plugin.zsh
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
source /home/ryanm/.rvm/scripts/rvm
source /usr/share/nvm/init-nvm.sh

export KEYTIMEOUT=0

# Let zsh be in vi mode
bindkey -v

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward
bindkey '^o' open-notes-vim


# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'

  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}

bindkey -s '^o' 'lfcd\n'  # zsh

alias tmux='tmux -u'
alias vim='nvim'
alias vimrc='nvim ~/.config/nvim'
alias zshrc='nvim ~/.zshrc'
alias tmuxconf='nvim ~/.tmux.conf'
alias poweroff='sudo poweroff'
alias reboot='sudo reboot'
alias ls='lsd'
alias gzip='pigz'

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# You can use whatever you want as an alias, like for Mondays:
#eval "$(thefuck --alias FUCK)"
eval "$(thefuck --alias)":

if [[ -n "$TMUX" ]] && [[ -z $ALREADY_RAN_TMUX_STARTUP ]]; then
    export ALREADY_RAN_TMUX_STARTUP=true;
    neofetch
fi

function zle-line-init zle-keymap-select {
    VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/}$(git_custom_status) $EPS1"
    zle reset-prompt
}

open-notes-vim() nvim $NOTES_DIR/$YEAR/$SEMESTER
zle -N open-notes-vim
zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1

export YEAR=`date +%Y`

if [[ `date +%m` =~ [0][1-5] ]]; then
    if [ `date +%m` = '01' ]; then
        export SEMESTER=Intersession
    else
        export SEMESTER=Spring
    fi
elif [[ `date +%m` =~ [0][6-8] ]]; then
    export SEMESTER=Summer
else
    export SEMESTER=Fall
fi

export DIR_DOTS="/home/ryanm/Documents/batcave/dotfiles"
export DIR_NOTES="/home/ryanm/Documents/batcave/Notes"
export DIR_TODO='/home/ryanm/Documents/batcave/Notes'
export DIR_PYTHON='/home/ryanm/Documents/batcave/python/csA131'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
