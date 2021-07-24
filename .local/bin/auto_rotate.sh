#!/usr/bin/env sh
# Auto rotate screen based on device orientation

# Receives input from monitor-sensor (part of iio-sensor-proxy package)
# Screen orientation and launcher location is set based upon accelerometer position
# Launcher will be on the left in a landscape orientation and on the bottom in a portrait orientation
# This script should be added to startup applications for the user

# Clear sensor.log so it doesn't get too long over time
> sensor.log

# Launch monitor-sensor and store the output in a variable that can be parsed by the rest of the script
monitor-sensor >> sensor.log 2>&1 &

# Parse output or monitor sensor to get the new orientation whenever the log file is updated
# Possibles are: normal, bottom-up, right-up, left-up
# Light data will be ignored
while inotifywait -e modify sensor.log; do
# Read the last line that was added to the file and get the orientation
ORIENTATION=$(tail -n 1 sensor.log | grep 'orientation' | grep -oE '[^ ]+$')

# Set the actions to be taken for each possible orientation
case "$ORIENTATION" in
normal)
xrandr --output eDP --rotate normal ;;
bottom-up)
xrandr --output eDP --rotate inverted ;;
right-up)
xrandr --output eDP --rotate right ;;
left-up)
xrandr --output eDP --rotate left ;;
esac
done
