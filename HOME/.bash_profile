#
# ~/.bash_profile
#

export PATH=~/bin:$PATH
export PATH=$PATH:/usr/bin/core_perl
export I_AM_LOCAL=y

[[ -f ~/.bashrc ]] && . ~/.bashrc
. /etc/profile.d/caps_super_switch.sh

[[ -f /home/benjamin/.xrandr-setup.sh ]] && . /home/benjamin/.xrandr-setup.sh
