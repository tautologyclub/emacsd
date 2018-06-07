#!/bin/sh

max_brt=$(cat /sys/class/backlight/intel_backlight/max_brightness)
i3status | while :
do
    time=$(date +%d/%m/%y\ \ %H:%M)
    brightness=$(cat /sys/class/backlight/intel_backlight/brightness)
    bright_pct=$(bc -l <<< "$brightness / ($max_brt + 0.1)" | cut -c2,3)
    read line
    echo "$line  | ☀ $bright_pct% |   $time" || exit 1
done
