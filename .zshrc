# Path to your oh-my-zsh installation.
export ZSH=/home/ryanm/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="ys"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
cargo
colored-man-pages
colorize
gem
git
github
perl
pip
python
rails
ruby
rvm
sudo
thefuck
tmux
vi-mode
zsh_reload
fast-syntax-highlighting)

# ===========[ User configuration ]========================================= {{{

#screenfetch # Display system/terminal info

alias tmux250='tmux -u new -s A250 -c /home/ryanm/batcave/C++/A250'
alias tmux200='tmux -u new -s A200 -c /home/ryanm/batcave/C++/A200'
alias tmux='tmux -u'
alias vim='nvim'
alias vimrc='nvim ~/.vimrc'
alias zshrc='nvim ~/.zshrc'
alias tmuxconf='nvim ~/.tmux.conf'
alias i3conf='nvim ~/.config/i3/config'
alias termconf='nvim ~/.config/termite/config'

source /usr/share/doc/fzf/key-bindings.zsh
source /usr/share/doc/fzf/completion.zsh
source /home/ryanm/.rvm/scripts/rvm

# You can use whatever you want as an alias, like for Mondays:
#eval "$(thefuck --alias FUCK)"
eval "$(thefuck --alias)":

if [[ -n "$TMUX" ]] && [[ -z $ALREADY_RAN_TMUX_STARTUP ]]; then
    export ALREADY_RAN_TMUX_STARTUP=true;
    neofetch
fi

# Let zsh be in vi mode
bindkey -v

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward
bindkey '^o' open-notes-vim

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

export EDITOR=nvim
export SEMESTER=Fall
export YEAR=2018
export NOTES_DIR="/home/ryanm/Documents/Notes"
export TODO_DIR='/home/ryanm/Documents/Notes'
# }}}

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/texlive/2018/bin/x86_64-linux:$HOME/.rvm/gems/ruby-2.5.0/bin:$HOME/Documents/Notes/:$HOME/.sh:$HOME/.local/bin"
export MANPATH="/usr/local/man:$MANPATH:/opt/texlive/2017/texmf-dist/doc/man:"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
