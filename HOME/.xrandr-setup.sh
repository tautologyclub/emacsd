#!/bin/bash -e
xrandr --output DP-2 --auto --left-of eDP-1 --primary || \
    notify-send "Couldn't set up DP-2"
