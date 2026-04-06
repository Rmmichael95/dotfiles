# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# --- XDG defaults & dirs ---
: "${XDG_STATE_HOME:=$HOME/.local/state}"
: "${XDG_CACHE_HOME:=$HOME/.cache}"
mkdir -p "$XDG_STATE_HOME/zsh" "$XDG_CACHE_HOME/zsh"

# --- 1. ENVIRONMENT & PATHS ---
# History configuration
HISTFILE="$XDG_STATE_HOME"/zsh/history
HISTSIZE=10000000
SAVEHIST=10000000
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
# setopt SHARE_HISTORY   # only if you really want cross-shell merging

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

# PRE-INIT: Define fpath with CachyOS/Arch optimized paths
# This MUST happen before compinit to find the _pacman script
fpath=(
  /usr/share/zsh/site-functions
  /usr/share/zsh/functions/Completion/Arch
  /usr/share/zsh/functions/Completion/Base
  /usr/share/zsh/functions/Completion/Linux
  /usr/share/zsh/functions/Completion/X11
  $fpath
)

# Load local custom functions if they exist
[ -e ${ZDOTDIR:-~}/.zsh_functions ] && fpath+=${ZDOTDIR:-~}/.zsh_functions

# --- 2. COMPLETION ENGINE ---
mkdir -p "${XDG_CACHE_HOME}/zsh"
autoload -Uz compinit
if [[ -n ${XDG_CACHE_HOME}/zsh/zcompdump(#qN.mh+24) ]]; then
  compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
else
  compinit -C -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
fi

# Ensure the cache directory exists to prevent silent initialization failure
mkdir -p "$XDG_CACHE_HOME/zsh"

# Completion Styling
zstyle ':completion:*' menu select
zmodload zsh/complist

# Pacman-specific completion fixes
zstyle ':completion:*:pacman:*' force-list always
zstyle ':completion:*:*:pacman:*' menu yes select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*:descriptions' format '%U%F{cyan}%d%f%u'
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"

# Map sudo-rs to use standard sudo completion logic
compdef _sudo sudo-rs

# Hidden files in autocomplete
_comp_options+=(globdots)

# Load bash completion compatibility
autoload -U +X bashcompinit && bashcompinit

# --- 3. KEYBINDINGS & VIM MODE ---
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
# Up/Down search with terminfo
if [[ -n "${terminfo[kcuu1]}" ]]; then
  autoload -U up-line-or-beginning-search
  zle -N up-line-or-beginning-search
  bindkey -M viins "${terminfo[kcuu1]}" up-line-or-beginning-search
  bindkey -M vicmd "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
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


autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

# Cursor shape handling for different vi modes
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

zle-line-init() {
  zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
  echo -ne "\e[5 q"
}
zle -N zle-line-init

zle -N cd_with_fzf
zle -N open_with_fzf

bindkey '^o' cd_with_fzf
bindkey '^f' open_with_fzf
bindkey '^v' nvim


# --- 4. EXTERNAL SOURCES & PLUGINS ---

# Load aliases and shortcuts if existent.
[ -e "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"
#[ -e "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc"
#[ -e "${XDG_CONFIG_HOME:-$HOME/.config}/shell/zshnameddirrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/zshnameddirrc"

# --- fzf (guarded) ---
[[ -r /usr/share/fzf/key-bindings.zsh ]] && source /usr/share/fzf/key-bindings.zsh
[[ -r /usr/share/fzf/completion.zsh   ]] && source /usr/share/fzf/completion.zsh

# alacritty completions
[ -e ${ZDOTDIR:-~}/.zsh_functions ] && fpath+=${ZDOTDIR:-~}/.zsh_functions


# Arch Linux command-not-found support, you must have package pkgfile installed
# https://wiki.archlinux.org/index.php/Pkgfile#.22Command_not_found.22_hook
[ -e /usr/share/doc/pkgfile/command-not-found.zsh ] && source /usr/share/doc/pkgfile/command-not-found.zsh

# --- history substring search ---
[[ -r /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh ]] && \
  source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

# --- Autosuggestions (before highlighting) ---
[[ -r /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && \
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# --- Syntax highlighting LAST ---
[[ -r /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && \
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# source nvm
[[ -r /usr/share/nvm/init-nvm.sh ]] && source /usr/share/nvm/init-nvm.sh

# --- 5. CUSTOM FUNCTIONS & INTEGRATIONS ---
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"
command -v starship >/dev/null && eval "$(starship init zsh)"

# Yazi wrapper, exit to cwd
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# zsh parameter completion for the dotnet CLI
_dotnet_zsh_complete()
{
  local completions=("$(dotnet complete "$words")")

  # If the completion list is empty, just continue with filename selection
  if [ -z "$completions" ]
  then
    _arguments '*::arguments: _normal'
    return
  fi

  # This is not a variable assignment, don't remove spaces!
  _values = "${(ps:\n:)completions}"
}

# --- 6. STARTUP ---
command -v dotnet >/dev/null && compdef _dotnet_zsh_complete dotnet
# tmux sessionizer
command -v tmux >/dev/null && source <(COMPLETE=zsh tms)
command -v op >/dev/null && eval "$(op completion zsh)"; compdef _op op
command -v dotnet >/dev/null || unset -f _dotnet_zsh_complete 2>/dev/null
command -v fastfetch >/dev/null && fastfetch
