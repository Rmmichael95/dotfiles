if status is-interactive
    # Commands to run in interactive sessions can go here
    eval (starship init fish)

    set -g fish_key_bindings fish_vi_key_bindings

    # yazi wrapper to exit to CWD
    function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end
