# ~/.bashrc: executed by bash(1) for non-login shells.


# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

shopt -s histappend             # append to the history file, don't overwrite it
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"            # sync after each command

# Unlimited history file size
HISTSIZE=
HISTFILESIZE=

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi
unset color_prompt force_color_prompt

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/:\1/'
}
if [ "$TERM" = "eterm-color" ]; then
    PS1="\[\033[01;31m\]\w\[\033[32m\]\[\033[00m\]\[\033[34m\]\$(parse_git_branch)\[\033[00m\]\n$ "
else
    PS1="\[\033[01;34m\]\w/\[\033[32m\]\[\033[00m\]\[\033[35m\]\$(parse_git_branch)\[\033[00m\]\n$ "
fi


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
if [ -f ~/.bash_bindings ]; then
    . ~/.bash_bindings
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export ALTERNATE_EDITOR=""
export EDITOR="emacsclient -t"                  # $EDITOR should open in terminal
export VISUAL="emacsclient -c -a emacs"         # $VISUAL opens in GUI with non-daemon as alternate

if [ -z "$(pgrep xcape)" ]; then
    xcape-restart || {
        notify-send "couldn't find xcape-restart in \$PATH"
    }
fi

# having $TERM==xterm-termite messes up remote terminals among other
# things. Easily fixed though:
if [[ $TERM == "xterm-termite" ]]; then
    export TERM=xterm-color
fi

test -e /usr/share/git/completion/git-completion.bash && \
    . /usr/share/git/completion/git-completion.bash

complete -cf sudo
complete -c man which systemctl killall eman wut
complete -f fdisk

# fuck -- kind of a cheesy util tbh
eval $(thefuck --alias)

export I_AM_LOCAL=y  # don't remember why I did this but I guess it's for ssh

# Remove duplicates in bash_history without affecting line number
cat -n ~/.bash_history | sort -uk2 | sort -nk1 | cut -f2- > ~/.bash_history_tmp
if [ -e ~/.bash_history_tmp ]; then
    mv ~/.bash_history_tmp ~/.bash_history
fi

sed -i 's/[[:space:]]*$//' ~/.bash_history
# Remove trailing whitespaces in bash_history

# random stupid fix for emacs term
my_dummy_binary 2>/dev/null || {
    export PATH=/home/benjamin/bin:$PATH
}
