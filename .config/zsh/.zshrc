# If not running interactively, don't do anything
[[ $- != *i* ]] && return

HISTFILE="$XDG_STATE_HOME"/zsh/history
HISTSIZE=10000000
SAVEHIST=10000000

autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

# Load aliases and shortcuts if existent.
[ -e "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"
#[ -e "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc"
#[ -e "${XDG_CONFIG_HOME:-$HOME/.config}/shell/zshnameddirrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/zshnameddirrc"

## Plugins section: Enable fish style features
# Use syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Use autosuggestion
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# Use history substring search
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

# Arch Linux command-not-found support, you must have package pkgfile installed
# https://wiki.archlinux.org/index.php/Pkgfile#.22Command_not_found.22_hook
[ -e /usr/share/doc/pkgfile/command-not-found.zsh ] && source /usr/share/doc/pkgfile/command-not-found.zsh

# alacritty completions
[ -e ${ZDOTDIR:-~}/.zsh_functions ] && fpath+=${ZDOTDIR:-~}/.zsh_functions

# Use fzf
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# perl
PATH="$XDG_DATA_HOME/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="$XDG_DATA_HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="$XDG_DATA_HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"$XDG_DATA_HOME/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=$XDG_DATA_HOME/perl5"; export PERL_MM_OPT;

fzf-history-widget-accept() {
  fzf-history-widget
  zle accept-line
}

zle     -N     fzf-history-widget-accept
bindkey '^X^R' fzf-history-widget-accept

# Find and edit using fzf
fe() {
  nvim "$(fd -type f | fzf --preview 'cat {}' --preview-window 'up:60%')"
}

frg() {
  RG_PREFIX="rga --files-with-matches"
  local file
  file="$(
    FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
      fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
        --phony -q "$1" \
        --bind "change:reload:$RG_PREFIX {q}" \
        --preview-window="70%:wrap"
  )" &&
  echo "opening $file" &&
  xdg-open "$file"
}

pe() {
  local file
  file=$(fd ~/.password-store -type f -name '*.gpg' | sed "s|^$HOME/.password-store/||;s|\.gpg$||" | fzf)
  if [ -n "$file" ]; then
    pass edit "$file"
  fi
}

# Find and remove files with fzf
frm() {
  # Use `find` to list files and directories, and pipe them to `fzf` for selection
  selected=$(fd . -type f -o -type d 2>/dev/null | fzf -m)

  # Check if any selection was made
  if [[ -n "$selected" ]]; then
    # Echo the files or directories that will be deleted
    echo "Deleting the following files or directories:"
    echo "$selected"

    # Use `xargs` to safely pass selected files/directories to `rm -rf`
    echo "$selected" | xargs -d '\n' rm -rf
  else
    echo "No files or directories selected."
  fi
}

ssh_fzf() {
  local host=$(grep "Host " ~/.ssh/config | cut -d " " -f 2 | fzf)
  if [[ -n $host ]]; then
    ssh "$host"
    else
      echo "No host selected"
    fi
}

## Options section
setopt correct               # Auto correct mistakes
setopt extendedglob          # Extended globbing. Allows using regular expressions with *
setopt nocaseglob            # Case insensitive globbing
setopt rcexpandparam         # Array expension with parameters
setopt nocheckjobs           # Don't warn about running processes when exiting
setopt numericglobsort       # Sort filenames numerically when it makes sense
setopt nobeep                # No beep
setopt appendhistory         # Immediately append history instead of overwriting
setopt histignorealldups     # If a new command is a duplicate, remove the older one
setopt autocd                # if only directory path is entered, cd there.
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus
setopt interactive_comments

# Completion.
autoload -Uz compinit

zstyle ':completion:*' menu select
zmodload zsh/complist
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' rehash true                              # automatically find new executables in path
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*:descriptions' format '%U%F{cyan}%d%f%u'
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $XDG_CACHE_HOME/zsh/zcompcache

# Include hidden files in autocomplete:
_comp_options+=(globdots)

# automatically load bash completion functions
autoload -U +X bashcompinit && bashcompinit

# Keys.
# Let zsh be in vi mode
bindkey -v

# [PageUp] - Up a line of history
if [[ -n "${terminfo[kpp]}" ]]; then
  bindkey -M viins "${terminfo[kpp]}" up-line-or-history
  bindkey -M vicmd "${terminfo[kpp]}" up-line-or-history
fi
# [PageDown] - Down a line of history
if [[ -n "${terminfo[knp]}" ]]; then
  bindkey -M viins "${terminfo[knp]}" down-line-or-history
  bindkey -M vicmd "${terminfo[knp]}" down-line-or-history
fi
# Start typing + [Up-Arrow] - fuzzy find history forward
if [[ -n "${terminfo[kcuu1]}" ]]; then
  autoload -U up-line-or-beginning-search
  zle -N up-line-or-beginning-search

  bindkey -M viins "${terminfo[kcuu1]}" up-line-or-beginning-search
  bindkey -M vicmd "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# Start typing + [Down-Arrow] - fuzzy find history backward
if [[ -n "${terminfo[kcud1]}" ]]; then
  autoload -U down-line-or-beginning-search
  zle -N down-line-or-beginning-search

  bindkey -M viins "${terminfo[kcud1]}" down-line-or-beginning-search
  bindkey -M vicmd "${terminfo[kcud1]}" down-line-or-beginning-search
fi
# [Home] - Go to beginning of line
if [[ -n "${terminfo[khome]}" ]]; then
  bindkey -M viins "${terminfo[khome]}" beginning-of-line
  bindkey -M vicmd "${terminfo[khome]}" beginning-of-line
fi
# [End] - Go to end of line
if [[ -n "${terminfo[kend]}" ]]; then
  bindkey -M viins "${terminfo[kend]}"  end-of-line
  bindkey -M vicmd "${terminfo[kend]}"  end-of-line
fi
# [Shift-Tab] - move through the completion menu backwards
if [[ -n "${terminfo[kcbt]}" ]]; then
  bindkey -M viins "${terminfo[kcbt]}" reverse-menu-complete
  bindkey -M vicmd "${terminfo[kcbt]}" reverse-menu-complete
fi
# [Backspace] - delete backward
bindkey -M viins '^?' backward-delete-char
bindkey -M vicmd '^?' backward-delete-char
# [Delete] - delete forward
if [[ -n "${terminfo[kdch1]}" ]]; then
  bindkey -M viins "${terminfo[kdch1]}" delete-char
  bindkey -M vicmd "${terminfo[kdch1]}" delete-char
else
  bindkey -M viins "^[[3~" delete-char
  bindkey -M vicmd "^[[3~" delete-char

  bindkey -M viins "^[3;5~" delete-char
  bindkey -M vicmd "^[3;5~" delete-char
fi

zle -N cd_with_skim
zle -N open_with_skim

bindkey '^o' cd_with_skim
bindkey '^f' open_with_skim
bindkey '^v' nvim

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

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

# source rbenv
# eval "$(rbenv init -)"

# source nvm
source /usr/share/nvm/init-nvm.sh

# yazi wrapper, exit to cwd
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

fastfetch

gpg-connect-agent updatestartuptty /bye >/dev/null

eval "$(op completion zsh)"; compdef _op op
