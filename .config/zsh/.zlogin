# Verify no display server is currently active
if [ -z "${WAYLAND_DISPLAY}" ] && [ -z "${DISPLAY}" ]; then

    # Let UWSM dictate if the current terminal/seat is valid for a session
#    if uwsm check may-start && uwsm select; then

        # INJECTION: Sync Zsh's natively generated PATH to systemd user manager
        # This prevents systemd from using default paths and hanging for 60 seconds
        systemctl --user import-environment PATH

        # Execute UWSM wrapped in systemd-cat for journaled logging
        exec systemd-cat -t uwsm_start uwsm start hyprland-uwsm.desktop
#    fi
fi
