#!/bin/bash

set -e


bashfile="$PWD/HOME/.bashrc"
xmodfile="$PWD/HOME/.Xmodmap"
i3file="$PWD/i3/config"

mv ~/.Xmodmap ~/.Xmodmap.bkup || true
mv ~/.bashrc ~/.bashrc.bkup || true
mv ~/.i3/config ~/.i3/config.bkup

cd ~
ln -s "$bashfile" .bashrc
ln -s "$xmodfile" .Xmodmap
ln -s "$i3file" .i3/config
