#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [[ -f ~/.extend.xinitrc ]];then
	. ~/.extend.xinitrc
else
	DEFAULT_SESSION=xfce4-session
fi

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

setxkbmap -option caps:super
setxkbmap -layout us

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

xmodmap -e "remove mod4 = Hyper_L"
xmodmap -e "add mod3 = Hyper_L"
# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

get_session(){
	local dbus_args=(--sh-syntax --exit-with-session)
	case $1 in
		awesome) dbus_args+=(awesome) ;;
		bspwm) dbus_args+=(bspwm-session) ;;
		budgie) dbus_args+=(budgie-desktop) ;;
		cinnamon) dbus_args+=(cinnamon-session) ;;
		deepin) dbus_args+=(startdde) ;;
		enlightenment) dbus_args+=(enlightenment_start) ;;
		fluxbox) dbus_args+=(startfluxbox) ;;
		gnome) dbus_args+=(gnome-session) ;;
		i3|i3wm) dbus_args+=(i3 --shmlog-size 0) ;;
		jwm) dbus_args+=(jwm) ;;
		kde) dbus_args+=(startkde) ;;
		lxde) dbus_args+=(startlxde) ;;
		lxqt) dbus_args+=(lxqt-session) ;;
		mate) dbus_args+=(mate-session) ;;
		xfce) dbus_args+=(xfce4-session) ;;
		openbox) dbus_args+=(openbox-session) ;;
		*) dbus_args+=($DEFAULT_SESSION) ;;
	esac

	echo "dbus-launch ${dbus_args[*]}"
}

exec $(get_session)


# twm &
# xclock -geometry 50x50-1+1 &
# xterm -geometry 80x50+494+51 &
# xterm -geometry 80x20+494-0 &
#exec xterm -geometry 80x66+0+0 -name login

if [ -f /home/benjamin/bin/xcape-restart ]; then
    /home/benjamin/bin/./xcape-restart
fi

if [ -f /home/benjamin/.xrandr-setup.sh ]; then
     . /home/benjamin/.xrandr-setup.sh
fi

# Try to shuffle monitors around
lsmod | grep nvidia && {
    nvidia-settings --assign "CurrentMetaMode=DPY-4: nvidia-auto-select @1920x1080 +4047+909 {ViewPortIn=1920x1080, ViewPortOut=1920x1080+0+0}, DPY-1: nvidia-auto-select @3840x2160 +0+0 {ViewPortIn=3840x2160, ViewPortOut=3840x2160+0+0}"
} || {
    notify-send -t 800 "NVIDIA driver not in use"
}

unclutter &
