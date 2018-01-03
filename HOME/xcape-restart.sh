#!/bin/bash

killall xcape
sleep 0.1

xcape -e 'Shift_L=F10;Shift_R=Control_L|x;Super_L=F11;Alt_R=F9'
xcape -e 'Mode_switch=semicolon'                                 # Reclaim ;
xcape -e 'Hyper_L=q'                                             # Reclaim q
