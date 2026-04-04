# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# --- 1. ENVIRONMENT & PATHS ---
# History configuration
HISTFILE="$XDG_STATE_HOME"/zsh/history
HISTSIZE=10000000
SAVEHIST=10000000

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
autoload -Uz compinit
if [[ -n ${XDG_CACHE_HOME}/zsh/zcompdump(#qN.mh+24) ]]; then
  compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
else
  compinit -C -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
fi

# Ensure the cache directory exists to prevent silent initialization failure
mkdir -p "$XDG_CACHE_HOME/zsh"

# Initialize compinit using the XDG Cache directory
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"

# Completion Styling
zstyle ':completion:*' menu select
zmodload zsh/complist

# Pacman-specific completion fixes
zstyle ':completion:*:pacman:*' force-list always
zstyle ':completion:*:*:pacman:*' menu yes select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
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
  zle -K viins
  echo -ne "\e[5 q"
}
zle -N zle-line-init

# --- 4. EXTERNAL SOURCES & PLUGINS ---
# Load aliases from your modular shell directory
[ -e "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"

# Plugin sources (Ensure these packages are installed via pacman)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

# Command-not-found support
[ -e /usr/share/doc/pkgfile/command-not-found.zsh ] && source /usr/share/doc/pkgfile/command-not-found.zsh

# FZF initialization
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# --- 5. CUSTOM FUNCTIONS & INTEGRATIONS ---
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

# Yazi wrapper, exit to cwd
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# --- 6. STARTUP ---
fastfetch
gpg-connect-agent updatestartuptty /bye >/dev/null
