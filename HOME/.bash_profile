#
# ~/.bash_profile
#

export EDITOR='emacsclient -c'
export VISUAL='emacsclient -c'

export PATH=$HOME/bin:$PATH:/sbin:$HOME/.local/bin:$PATH

export I_AM_LOCAL=y
touch /tmp/.bash_profile.sourced

[[ -f /etc/profile.d/caps_super_switch.sh ]] && \
    . /etc/profile.d/caps_super_switch.sh

[[ -f /home/benjamin/.xrandr-setup.sh ]] && \
    . /home/benjamin/.xrandr-setup.sh

[[ -f ~/.bashrc ]] && \
    . ~/.bashrc
. "$HOME/.cargo/env"
