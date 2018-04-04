#!/bin/bash

killall xcape
setxkbmap -layout us
xmodmap /home/benjamin/.Xmodmap

sleep 0.2

xcape -e 'Control_L=F12'
xcape -e 'Shift_L=F10;Shift_R=Control_L|x;Super_L=F11;Alt_R=F9'
xcape -e 'Mode_switch=semicolon'                                 # Reclaim ;
xcape -e 'Hyper_L=q'                                             # Reclaim q
xcape -e 'Alt_L=F7'
