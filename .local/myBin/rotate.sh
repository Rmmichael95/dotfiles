#!/bin/env sh

#screen="eDP1"
xrandrout=$(xrandr | grep -Eo -m 1 'current.{12}')
touch="Wacom HID 5214 Finger"
transform="Coordinate Transformation Matrix"
right="0 1 0 -1 0 1 0 0 1"
normal="1 0 0 0 1 0 0 0 1"

case $xrandrout in
 "current 1920 x 1080")
     xrandr -o 3
     xinput set-prop "$touch" "$transform" $right
     ;;
 "current 1080 x 1920")
     xrandr -o 0
     xinput set-prop "$touch" "$transform" $normal
     ;;
esac
