#!/bin/sh

# Backlight level from systemd's perspective (change if needed)
readonly SYSTEMD_BACKLIGHT_FILE='/var/lib/systemd/backlight/pci-0000:04:00.0:backlight:amdgpu_bl0'

# Backlight level from AMDGPU driver
readonly AMDGPU_BACKLIGHT_FILE='/sys/class/backlight/amdgpu_bl0/brightness'

# Read current value from the driver and apply it to systemd
readonly AMDGPU_BACKLIGHT_VALUE=$(cat "$AMDGPU_BACKLIGHT_FILE")
echo "$AMDGPU_BACKLIGHT_VALUE" > "$SYSTEMD_BACKLIGHT_FILE"
