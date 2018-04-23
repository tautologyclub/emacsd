#!/bin/bash -e

i3file="$PWD/i3/config"
homefiles="$PWD/HOME/.bashrc $PWD/HOME/.Xmodmap $PWD/HOME/.bash_aliases \
           $PWD/HOME/.bash_bindings $PWD/HOME/.xinitrc"
binfiles="$PWD/bin/chr-deb $PWD/bin/E $PWD/bin/split_optimal \
          $PWD/bin/wut $PWD/bin/xcape-restart $PWD/bin/xcape-restart-swedish"

for file in "$homefiles"; do
    ln -f $file ~/$file
done

for file in "$binfiles"; do
    ln -f $file ~/bin/$file
done

if [ -d ~/.i3 ]; then
    ln -f "$i3file" ~/.i3//config
else
    ln -f "$i3file" ~/.config/i3//config || {
        echo "wtf no i3"
        exit 1
    }
if
