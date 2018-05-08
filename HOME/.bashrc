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
    PS1="\[\033[01;34m\]\w/\[\033[32m\]\[\033[00m\]\[\033[34m\]\$(parse_git_branch)\[\033[00m\]\n$ "
    # PS1="\[\033[01;35m\]\$PWD\[\033[32m\]\[\033[00m\]\[\033[34m\]\$(parse_git_branch)\[\033[00m\]\n$ "
else
    PS1="\[\033[01;34m\]\w/\[\033[32m\]\[\033[00m\]\[\033[35m\]\$(parse_git_branch)\[\033[00m\]\n$ "
fi

# PS1='${debian_chroot:+($debian_chroot)}\[\033[02;35m\]\u@\h\[\033[00m\]:\[\033[01;33m\]\w\[\033[00m\]\n\$ '

# If this is an xterm set the title to user@host:dir (this is an emacs
# terminal fix)
# case "$TERM" in
# xterm*|rxvt*)
#     PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
#   ;;
# *)
#     ;;
# esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -al'
alias la='ls -A'
alias l='ls -CF'

# source some temporary aliases
. ~/.config/tmp_aliases.sh

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

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

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ls='ls --color -h --group-directories-first'

alias rm='gio trash'
alias seetrash='ll ~/.local/share/Trash/files/'
alias emptytrash='sudo /bin/rm -rf ~/.local/share/Trash/*'
alias xclip='xclip -selection clipboard'

# This is fkng awesome
alias sharedir='python2 -c "import SimpleHTTPServer;SimpleHTTPServer.test()"'

export ALTERNATE_EDITOR=""
export EDITOR="emacsclient -t"                  # $EDITOR should open in terminal
export VISUAL="emacsclient -c -a emacs"         # $VISUAL opens in GUI with non-daemon as alternate

# setxkbmap -layout us; xmodmap ~/.Xmodmap
if [ -z "$(pgrep xcape)" ]; then
    xcape -e 'Control_L=F12'
    xcape -e 'Shift_L=F10;Shift_R=Control_L|x;Super_L=F11;Alt_R=F9'
    xcape -e 'Mode_switch=semicolon'                                 # Reclaim ;
    xcape -e 'Hyper_L=q'                                             # Reclaim q
    xcape -e 'Alt_L=F7'
fi

# having $TERM==xterm-termite messes up remote terminals among other
# things. Easily fixed though:
if [[ $TERM == *"xterm"* ]]; then
    # echo Renaming "$TERM" to xterm
    export TERM=xterm
fi

. /usr/share/git/completion/git-completion.bash

complete -cf sudo
complete -c man which systemctl killall eman wut

# fuck -- kind of a cheesy util tbh
eval $(thefuck --alias)

export PATH=~/bin:$PATH
export I_AM_LOCAL=y

# Remove duplicates in bash_history without affecting line number
cat -n ~/.bash_history | sort -uk2 | sort -nk1 | cut -f2- > ~/.bash_history_tmp
mv ~/.bash_history_tmp ~/.bash_history

# Remove trailing whitespaces in bash_history
sed -i 's/[[:space:]]*$//' ~/.bash_history
