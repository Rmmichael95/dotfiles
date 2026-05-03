#!/usr/bin/env sh
# ~/.config/eww/scripts/coordinate.sh
#
# Replaces coordinate.py — queries GeoClue2 via where-am-i, writes
# "lat,lon" to coordinate.txt for eww weather widgets to consume.
#
# Usage: called by eww as a script poll, or via middle-click button.
#
# Deps: geoclue2 (where-am-i), ripgrep (rg), awk

COORD_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/eww/scripts/coordinate.txt"

notify-send "GeoClue" "Fetching location…"

# where-am-i outputs e.g. "Latitude:  34.05230°"
# rg filters to lat/lon lines, awk pulls the value, sed strips the degree symbol
coords=$( \
  /usr/lib/geoclue-2.0/demos/where-am-i 2>/dev/null \
  | rg 'Latitude:|Longitude:' \
  | awk '{print $2}' \
  | sed 's/[°]$//' \
  | paste -sd ',' \
)

if [ -z "$coords" ]; then
  notify-send -u critical "GeoClue" "Failed to get location — is geoclue-agent.service running?"
  exit 1
fi

printf '%s' "$coords" > "$COORD_FILE"
notify-send "GeoClue" "Location updated: $coords"
