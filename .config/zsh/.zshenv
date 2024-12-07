# PATH
typeset -U PATH path
typeset -T LD_LIBRARY_PATH ld_library_path :
path=("/usr/local/sbin/" "/usr/local/bin/" "/usr/sbin/" "/usr/bin/" "/sbin/" "/bin/" "/usr/lib/ccache/bin/" $path)
path+=("$HOME/.local/bin/" "$HOME/.local/share/npm/bin/" "$HOME/.config/composer/vendor/bin/" "$HOME/.nix-profile/bin/")
export PATH

source $HOME/.config/shell/profile
