#!/bin/sh

[ `cat /sys/class/power_supply/ADP1/online` -eq 1 ]; \
    cat /sys/class/power_supply/ADP1/online
