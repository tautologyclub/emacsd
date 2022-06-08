# Auxilliary shell helpers
HACKY_ALIASES=true      # Warning, unset this is you're not into hacky hacks

PANIC_MSG_PREFIX="*** Error: "
FILE_ASSERT_MAXSIZE_DFLT="$(echo 2^32 | bc)"

MEM()
{
    ps -eo rss,pid,euser,args:100 --sort %mem | grep -v grep | grep -i $@ | awk '{printf $1/1024 "MB"; $1=""; print }'
}


errcho()
# Usage:  Just like echo xyz, but to stderr
{
    echo "$*" 1>&2
}

ctl()
# Usage: Faster way to call sudo systemctl
{
    local PREFIX=sudo
    case "$1" in
        -u)          PREFIX=""
                     shift ;;
        --help)      PREFIX="" ;;
        status)      PREFIX="" ;;
        list-*)      PREFIX="" ;;
        is-*)        PREFIX="" ;;
        show)        PREFIX="" ;;
        help)        PREFIX="" ;;
        cat)         PREFIX="" ;;
        show*)       PREFIX="" ;;
        get-default) PREFIX="" ;;
    esac

    $PREFIX systemctl "$@"
}

panic()
# Panics and exits. Warning: don't use this in scripts you intend to source :)
# Usage:  panic <msg>
{
    echo -n "$PANIC_MSG_PREFIX" 1>&2
    errcho "$@"
    exit 1
}

require()
# Give up early rather than late! This function is so nice it should be a POSIX
# built-in. Usage:
#       require [-s|-x|-p] $app1 $app2 $app3 ...
#
# Flags:
#       -s|--sudo       Require that the program is in sudo:s $PATH.
#                       Note:  Pretty damn unsafe...
#       -x|--executable Require that the program is an executable, i.e. no shell
#                       functions, aliases etc. allowed.
#       -p|--path       Echo the required path(s) to stdout.
{
    local checker_prefix=""
    local checker="command -v"          # Default checker
    local return_cmdpath=/dev/null      # Default to not returning path
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -p|--path)
                return_cmdpath=/dev/stdout
                shift ;;
            -x|--executable)
                checker=/usr/bin/which
                shift ;;
            -s|--sudo)
                checker_prefix=sudo
                checker=/usr/bin/which
                shift ;;
            -*) errcho "Unknown flag $1"
                return 1 ;;
             *) break ;;
        esac
    done

    for cmd in "$@" ; do
        eval $checker_prefix $checker "$cmd" > $return_cmdpath 2>/dev/null || {
            errcho "$cmd not found (using $checker_prefix $checker)"
            return 1
        }
    done
}

var_assert()
# Assert variable is set. Accepts list of variables, i.e. 'var_assert foo bar
# baz' checks if $foo, $bar and $baz are all set. With -n|--non-empty flag
# provided, also asserts the variables are non-nil.
#
# -- NOTE: kind of unsafe due to eval so only ever call this with actual string
#          literals!
{
    while [ "$#" -gt 0 ]; do
        case $1 in
            -n|--non-empty)  # require that variable be non-empty string
                local check_non_empty=1
                shift
                ;;
            -*) errcho "Unknown flag $1"
                return 1
                ;;
             *) break
                ;;
            esac
        done

    for var_name in "$@"; do
        if [ -n "$check_non_empty" ]; then
            eval var_val="\$$var_name" && test -n "$var_val"
        else
            declare -p "$var_name" >/dev/null 2>&1
        fi
    done
}

file_size()
#Usage:  file_size $filename
{
    stat -c %s "$1"
}

FILE_ASSERT_MAXSIZE_DFLT="$(echo 2^32 | bc)"
file_assert()
# Assert file(s) exists.
# Usage:
#       file_assert [-s MINSIZE|-S MAXSIZE] file1 file2 ...
{
    local actual_filesize minsize=0 maxsize=$FILE_ASSERT_MAXSIZE_DFLT
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -s|--minsize) minsize=$2
                          shift; shift                  ;;
            -S|--maxsize) maxsize=$2
                          shift; shift                  ;;
                      -*) errcho "Unknown flag $1"
                          return 1                      ;;
                       *) break                         ;;
        esac
    done
    [[ "$#" -eq "0" ]] && errcho No file path provided! && return 1

    for file in "$@"; do
        test -e "$file" && {
            actual_filesize=$(file_size "$file")
            if [ "$actual_filesize" -lt "$minsize" ]; then
                errcho "'$file subceeds' min. size ($actual_filesize < $minsize)"; return 1
            elif [ "$actual_filesize" -gt "$maxsize" ]; then
                errcho "'$file' exceeds max. size ($actual_filesize > $maxsize)"; return 1
            fi
        } || {
            errcho "File $file does not exist!"
            return 1
        }
    done
}

with_pwd()
# Eval CMD with DIR as working directory. Usage:
#     with_pwd DIR CMD
{
    local prev_dir=$PWD
    cd "$1" && shift && eval "$@" || local ret=$?
    cd "$prev_dir"
    return $ret
}

random_string()
# A random "normal" string of length $1 (useful for file names and stuff where
# you might not want spaces or escape characters)
# Usage:  random_string $len
{
    cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w "$1" | head -n 1
}

random_hex()
# A random "normal" string of length $1 (useful for file names and stuff where
# you might not want spaces or escape characters)
# Usage:  random_string $len
{
    if [[ "$1" == "-c" ]]; then
        echo C STYLE NOT IMPLEMENTED
        shift
        cat /dev/urandom | tr -dc 'a-f0-9' | fold -w "$1" | head -n 1
    else
        cat /dev/urandom | tr -dc 'a-f0-9' | fold -w "$1" | head -n 1
    fi
}

random_file()
# Generate a random file of $1 bytes with name $2
# Usage:  random_file $name $size
{
    head -c "$2" < /dev/urandom > "$1"
}

cpwd()
# If you don't have a terminal that lets you navigate through stdout, this one's
# golden. But also, check out 'termite'. Best solution is to put
#
#     alias xclip='xclip -selection clipboard'
#
# in your .bashrc.
{
    require xclip
    pwd | xclip -selection clipboard
}

hex_to_dec()
# Usage:  hex_to_dec [0x]DEADBEEF
{
    printf "%d" "$1"
}

subdirs()
# List only subdirs
{
    ls -d */ || echo ""
}

mkcd()
# Make a dir, cd to it
{
    mkdir $* && cd "${@: -1}"
}

pid_alive()
# For pinging processes -- errors out if $pid isn't alive and does nothing at
# all if it is.
# Usage:  pid_alive $pidlist || errcho "uh-oh"
{
    kill -s 0 "$@"
}

app_alive()
# Like pid_alive but for processes (with pids obtainable via pgrep)
{
    for app in "$@"; do
        pgpid=$(pgrep $app)
        [[ "$?" = "0" ]] || {
            echo "$app not alive"
            return 1
        }
        pid_alive $pgpid || {
            echo "$app has pid $pgpid but can't be killpinged"
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
        echo "Mount point $mpoint not empty!"
        return 1
    }
    sudo mount /dev/"$1" "$mpoint" &&                           \
        echo "Mounted /dev/$1 on $mpoint" &&                  \
        export LAST_MOUNTIE_POINT=$mpoint
    which xclip > /dev/null && echo -n "cd $mpoint" | xclip || true
}

umountie(){
    require sudo mountie

    if [ -z "$LAST_MOUNTIE_POINT" ]; then
        errcho "Ambiguous mount point, sorry"
        return 1
    fi

    if [[ "$LAST_MOUNTIE_POINT" == "$PWD" ]]; then
        cd ~
    fi

    echo Unmounting "$LAST_MOUNTIE_POINT..."
    sudo umount "$LAST_MOUNTIE_POINT" && \
        unset LAST_MOUNTIE_POINT
}

girl()
# Convenience for recursively greping
{
    # -I : ignore binary
    # -R : recursive
    # -l : list files, not matching lines
    grep -IRl "$@" 2>/dev/null
}


ff()
# Convenience for grepping for file names
{
    find . 2>/dev/null | grep "$@"
}

ful() {
# Grepping for file names, but with full path
    find "$PWD" 2>/dev/null | grep "$@"
}

alias ln='ln -v'
alias xclip='xclip -selection clipboard'

alias make='make -j$(nproc)'

# always log serial console sessions, use color and default to ttyUSB0
alias minicom='/usr/bin/minicom -D /dev/ttyUSB0 --color=on -C /tmp/minicom.cap'

# less interprets colors/escape chars
alias less='less -r'

test -f ~/.config/systemd/user/rttlog.service && test ! -f ~/bin/rttlog && {
        alias rttlog='systemctl --user restart rttlog'
    }


mkdir -p "$HOME/log"
MC()
{
    /usr/bin/minicom -D /dev/ttyUSB0 --color=on -C "$HOME/log/minicom-$(date +%y%m%d-%H%M).cap" "$@"
}

export -f MC


y_prompt()
# Prompts user for a single input char. Returns true iff input is y/Y.
#  - Usage: y_prompt [string]
# - Example: add the following to your .bash_aliases
#       alias poweroff='y_prompt poweroff && poweroff'
{
    read -p "Really $1? " -n 1 -r
    echo ""
    [[ $REPLY =~ ^[Yy]$ ]]
}

if require i3exit 2>/dev/null ; then
    alias logout='y_prompt logout && i3exit logout'
    alias suspend='y_prompt suspend && i3exit suspend'
    alias poweroff='y_prompt poweroff && i3exit poweroff'
    alias lock='i3exit lock'
    alias hibernate='i3exit hibernate'
    alias reboot='y_prompt reboot && i3exit reboot'
fi

if [ -n "$HACKY_ALIASES" ]; then
    alias sharedir='python2 -c "import SimpleHTTPServer;SimpleHTTPServer.test()"'

    alias ll='ls -alh'
    alias ls='ls --color -h --group-directories-first'
    alias grep='grep -s'

    alias ..='cd ..'
    alias ...='cd ../..'
    alias ....='cd ../../..'
    alias .....='cd ../../../..'
    alias ......='cd ../../../../..'

    alias gdb='gdb -q -iex "set auto-load safe-path $HOME/.gdb"'
    alias PORTCHECK='lsof -i -P -n | less'
    alias PWD='echo -n $PWD | xclip'

    require gio && {
        alias rm='gio trash'
        alias seetrash='ll ~/.local/share/Trash/files/'
        alias emptytrash='sudo /bin/rm -rf ~/.local/share/Trash/*'
    }
fi

colors()
{
# Stolen from /etc/skel
    local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}

extract ()
{
    if [ -f "$1" ] ; then
        case "$1" in
            *.tar.bz2)   tar xjf "$*"   ;;
            *.tar.gz)    tar xzf "$*"   ;;
            *.bz2)       bunzip2 "$*"   ;;
            *.rar)       unrar x "$*"     ;;
            *.gz)        gunzip "$*"    ;;
            *.tar)       tar xf "$*"    ;;
            *.tbz2)      tar xjf "$*"   ;;
            *.tgz)       tar xzf "$*"   ;;
            *.zip)       unzip "$*"     ;;
            *.Z)         uncompress "$*";;
            *.7z)        7z x "$*"      ;;
            *.xz)        tar xf "$*"      ;;
            *)           echo "'$1' cannot be extracted via ex()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

ssh_and_track ()
{
    # Todo: extract [user@]destination and save it to some file
    /usr/bin/ssh "$*"
}

alias gnome-control-center='env XDG_CURRENT_DESKTOP=GNOME gnome-control-center'

# daniels emqx script
# voi ()
# {
#     local urn
#     local cmd
#     if [[ "$2" == *"urn"* ]]; then
#         urn="$2"
#     else
#         urn="urn:imei:$2"
#     fi
#     cmd="$1 $urn ${@:3}"
#     python3 -u -m emqxlwm2m --host dev-mqtt.iot.stage.voiapp.io --known-endpoints ~/work/voi/.notes/scooters.txt -x ~/work/voi/ng-iot-platform/lwm2m_objects -t 5 --echo $cmd
# }

voi_port_fwd ()
{
    # kubectl port-forward svc/ng-iot-emqx 1883:1883

    # Set up PF explicitly to dev
    # kubectl port-forward svc/mosquitto-gw 1883 --context gke_entropy-iot-prod_europe-north1-b_ng-iot-dev
    kubectl port-forward service/ng-iot-mosquitto-gw 1883:1883
}

voi_port_fwd_stageprod ()
{
    kubectl --context gke_entropy-iot-prod_europe-north1-b_ng-iot-staging port-forward pods/ng-iot-emqx-0 1883:1883
}

voiprod ()
{
    python3 -u -m emqxlwm2m --host localhost --known-endpoints ~/work/voi/.notes/scooters.txt -x ~/work/voi/ng-iot-platform/lwm2m_objects -t 5 --echo "$@"
}

# voiprod ()
voi ()
{
    local urn
    local cmd
    if [[ "$2" == *"urn"* ]]; then
        urn="$2"
    else
        urn="urn:imei:$2"
    fi
    cmd="$1 $urn ${@:3}"
    python3 -u -m emqxlwm2m --host localhost --known-endpoints ~/work/voi/.notes/scooters.txt -x ~/work/voi/ng-iot-platform/lwm2m_objects -t 5 --echo $cmd
}

voi_unlock ()
{
    voi write urn:imei:$1 /34120/0/2 --value 2
}

voi_lock ()
{
    voi write urn:imei:$1 /34120/0/2 --value 1
}
