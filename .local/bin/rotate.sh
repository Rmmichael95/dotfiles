#!/bin/env sh

screen="eDP1"
touchscreen="Atmel Atmel maXTouch Digitizer"

orientationCmd="xrandr"
orientationRE="$(cat ~/.local/bin/orientation.txt 2>/dev/null)"

case $orientationRE in
    "normal")  # Screen is not rotated, we should rotate it right (90°)
           xrandr -o 3
           echo right > ~/.local/bin/orientation.txt
#           xfconf-query -c pointers -p /Wacom_ISDv4_90_Pen_stylus/Properties/Wacom_Rotation -s 1
#           xfconf-query -c xsettings -p /Xft/RGBA -s vbgr
           ;;
    "right")    # Top of screen is rotated right, we should invert it (180°)
           xrandr -o 2
           echo inverted > ~/.local/bin/orientation.txt
#           xfconf-query -c pointers -p /Wacom_ISDv4_90_Pen_stylus/Properties/Wacom_Rotation -s 3
#           xfconf-query -c xsettings -p /Xft/RGBA -s bgr
           ;;
    "inverted")  # Screen is inverted, we should rotate it left (270°)
           xrandr -o 1
           echo left > ~/.local/bin/orientation.txt
#           xfconf-query -c pointers -p /Wacom_ISDv4_90_Pen_stylus/Properties/Wacom_Rotation -s 2
#           xfconf-query -c xsettings -p /Xft/RGBA -s vrgb
           ;;
    "left")  # Currently top is rotated left, we should set it normal (0°)
           xrandr -o 0
           echo normal > ~/.local/bin/orientation.txt
#          xfconf-query -c pointers -p /Wacom_ISDv4_90_Pen_stylus/Properties/Wacom_Rotation -s 0
#          xfconf-query -c xsettings -p /Xft/RGBA -s rgb
          ;;
    *)
           echo "Unknown result" >&2
           exit 1
           ;;
esac
