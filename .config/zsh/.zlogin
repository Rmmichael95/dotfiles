# Verify no display server is active, and we are not logging in via SSH
if [ -z "${WAYLAND_DISPLAY}" ] && [ -z "${DISPLAY}" ] && [ -z "${SSH_CONNECTION}" ]; then

    # INJECTION: Sync Zsh's natively generated PATH to systemd user manager
    # This prevents systemd from using default paths and hanging for 60 seconds
    systemctl --user import-environment PATH

    # Execute UWSM wrapped in systemd-cat for journaled logging
    exec systemd-cat -t uwsm_start uwsm start hyprland-uwsm.desktop
    #start-hyprland
fi
