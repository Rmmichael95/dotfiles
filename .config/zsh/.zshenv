# --- PATH ARCHITECTURE ---
# typeset -U PATH path
# typeset -T LD_LIBRARY_PATH ld_library_path :

# Core System Paths
#path=(/usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/lib/ccache/bin $path)

# User & Native Zsh Recursive Paths (Replaces slow 'fd' command)
#path+=("$HOME/.local/bin" "$HOME/.local/share/npm/bin" "$HOME/.config/composer/vendor/bin" "$HOME/.nix-profile/bin")
#path+=("$HOME"/.local/bin/myBin/**/*(/N))
#path+=("$HOME/.local/share/go/bin")

#export PATH

source $HOME/.config/keys
