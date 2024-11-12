if status is-interactive
    # Commands to run in interactive sessions can go here
    eval (starship init fish)

    set -g fish_key_bindings fish_vi_key_bindings
end
