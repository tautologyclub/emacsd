#!/bin/bash -e
# xrandr --output DP-1 --auto --primary --left-of eDP-1 --primary || \
    # notify-send "Couldn't set up DP-2"
xrandr --output DP-1 --auto --primary --right-of eDP-1 --primary
xrandr --output eDP-1 --brightness 1.2
