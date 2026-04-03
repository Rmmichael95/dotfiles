#!/bin/sh
if [ "$1" = "HDMI-A-1" ]; then
    # Re-enable laptop screen at preferred settings
    hyprctl keyword monitor "eDP-1,highres@highrr,auto,1,transform,0"
fi
