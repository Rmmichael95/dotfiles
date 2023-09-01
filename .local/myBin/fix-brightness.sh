#!/bin/bash

# Change the line below according to your hardware
BRIGHTNESS_FILE="/var/lib/systemd/backlight/pci-0000:04:00.0:backlight:amdgpu_bl0"
BRIGHTNESS=$(cat "$BRIGHTNESS_FILE")
BRIGHTNESS=$(($BRIGHTNESS*255/65535))
BRIGHTNESS=${BRIGHTNESS/.*} # truncating to int, just in case
echo $BRIGHTNESS > "$BRIGHTNESS_FILE"
