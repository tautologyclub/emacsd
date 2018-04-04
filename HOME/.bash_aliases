errcho()
# just like echo, but to stderr!
{
    # Usage:  errcho [-flags] $string
    echo -n "ERROR: " 1>&2
    echo "$*" 1>&2
}


require()
# Give up early rather than late! (this one's actually amazing)
# Note: you can actually require require! I.e. command -v works for binaries,
# shell built-ins, aliases, everything.
{
    # Usage:  require $app1 $app2 $app3 ...
    for cmd in "$@" ; do
        command -v "$cmd" > /dev/null || {
            errcho "$cmd not found!"
            return 1
        }
    done
}


mountie()
# Because typing mount commands is really boring
{
    # Usage:  mountie [$dev]
    require sudo

    mpoint=/mnt/"$1"
    sudo mkdir -p "$mpoint"

    # Ensure moint point is empty, then mount (this works because ls $dir/*
    # errors out if $dir is empty -- mm, tasty hacks...)
    ls "$mpoint/*" > /dev/null 2>&1 && {
        errcho "Mount point $mpoint not empty!"
        return 1
    }
    sudo mount /dev/"$1" "$mpoint" &&                           \
        errcho "Mounted /dev/$1 on $mpoint" &&                  \
        export LAST_MOUNTIE_POINT=$mpoint
}

umountie(){
    require sudo
    require mountie
    if [ -z "$LAST_MOUNTIE_POINT" ]; then
        errcho "Ambiguous mount point, sorry"
        return 1
    fi
    errcho Unmounting "$LAST_MOUNTIE_POINT..."

    sudo umount "$LAST_MOUNTIE_POINT"
}


pid_alive()
# For pinging processes -- errors out if $pid isn't alive and does nothing at
# all if it is.
{
    # Usage:  pid_alive $pidlist || errcho "uh-oh"
    kill -s 0 "$@"
}
