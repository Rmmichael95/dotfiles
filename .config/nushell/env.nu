# Nushell Environment Config File
#
# version = "0.99.1"

$env.STARSHIP_SHELL = "nu"

def create_left_prompt [] {
    starship prompt --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)'
}

# Use nushell functions to define your right and left prompt
$env.PROMPT_COMMAND = { || create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = ""

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = ": "
$env.PROMPT_INDICATOR_VI_INSERT = ""
$env.PROMPT_INDICATOR_VI_NORMAL = "〉"
$env.PROMPT_MULTILINE_INDICATOR = "::: "

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
    "PATH": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
    "Path": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
}

# Directories to search for scripts when calling source or use
# The default for this is $nu.default-config-dir/scripts
$env.NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts') # add <nushell-config-dir>/scripts
    ($nu.data-dir | path join 'completions') # default home for nushell completions
]

# Directories to search for plugin binaries when calling register
# The default for this is $nu.default-config-dir/plugins
$env.NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins') # add <nushell-config-dir>/plugins
]

# ENV
#$env.SSH_AUTH_SOCK = $"($env.XDG_RUNTIME_DIR)/ssh-agent.socket"

mkdir $"($env.XDG_CACHE_HOME)/starship"
starship init nu | save -f $"($env.XDG_CACHE_HOME)/starship/init.nu"
$env.STARSHIP_CONFIG = $"($env.XDG_CONFIG_HOME)/starship/starship.toml"

mkdir $"($env.XDG_CACHE_HOME)/zoxide"
zoxide init nushell | save -f $"($env.XDG_CACHE_HOME)/zoxide/init.nu"

mkdir $"($env.XDG_CACHE_HOME)/carapace"
carapace _carapace nushell | save --force $"($env.XDG_CACHE_HOME)/carapace/init.nu"
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
# An alternate way to add entries to $env.PATH is to use the custom command `path add`
# which is built into the nushell stdlib:
use std "path add"
# $env.PATH = ($env.PATH | split row (char esep))
# path add /some/path
# path add ($env.CARGO_HOME | path join "bin")
# path add ($env.HOME | path join ".local" "bin")
# $env.PATH = ($env.PATH | uniq)
#$env.PATH = ($env.PATH | split row (char esep))
# $env.PATH = ($env.PATH | split row (char esep) | prepend "/usr/local/sbin/")
# $env.PATH = ($env.PATH | split row (char esep) | prepend "/usr/local/bin/")
# $env.PATH = ($env.PATH | split row (char esep) | prepend "/usr/sbin/")
# $env.PATH = ($env.PATH | split row (char esep) | prepend "/usr/bin/")
# $env.PATH = ($env.PATH | split row (char esep) | prepend "/sbin")
# $env.PATH = ($env.PATH | split row (char esep) | prepend "/bin")
# $env.PATH = ($env.PATH | split row (char esep) | prepend "/usr/lib/ccache/bin/")
# $env.PATH = ($env.PATH | split row (char esep) | prepend "~/.local/bin/myBin")
# $env.PATH = ($env.PATH | split row (char esep) | prepend "$(fd . -t d ~/.local/bin/myBin)")

# To load from a custom file you can use:
# source ($nu.default-config-dir | path join 'custom.nu')

