#!/bin/bash

BRFILE=/sys/class/backlight/amdgpu_bl0/brightness

increase() {
    cur=$(cat $BRFILE)
    echo current = $cur

    new=$((cur+$1))
    new=$(( new > 255 ? 255 : new))

    echo $new > $BRFILE
    echo new = $(cat $BRFILE)
}

decrease() {
    cur=$(cat $BRFILE)
    echo current = $cur

    new=$((cur-$1))
    new=$(( new < 0 ? 0 : new))

    echo $new > $BRFILE
    echo new = $(cat $BRFILE)
}

absolute() {
    cur=$(cat $BRFILE)
    echo current = $cur

    echo $1 > $BRFILE
    echo new = $(cat $BRFILE)
}

arg=$1
case $arg in
    +*) increase ${arg:1} ;;
    -*) decrease ${arg:1} ;;
    *) absolute $1 ;;
esac
