#!/bin/bash

if [ -z "$(pgrep emacs)" ]; then
    emacs --daemon
    if [ -z "$(pgrep emacs)"]; then
        notify-send "Failed to start daemon"
    else
        notify-send "emacs --daemon started"
    fi
else
    notify-send "emacs --daemon already running...?"
fi
