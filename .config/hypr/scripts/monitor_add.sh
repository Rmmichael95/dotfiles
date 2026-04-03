#!/bin/sh
# $1 is the monitor name passed by hyprland-monitor-attached

if [ "$1" = "HDMI-A-1" ]; then
    # 1. Enable HDMI at max resolution/refresh rate
    hyprctl keyword monitor "HDMI-A-1, highres@highrr, 0x0, 2"

    # 2. Disable the laptop screen
    hyprctl keyword monitor "eDP-1, disable"

    # 3. Move all workspaces (1-10) to the new HDMI monitor
    for i in $(seq 1 10); do
        hyprctl dispatch moveworkspacetomonitor "$i" HDMI-A-1
    done
fi
