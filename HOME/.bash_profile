#
# ~/.bash_profile
#

export PATH=~/bin:$PATH
export I_AM_LOCAL=y

[[ -f ~/.bashrc ]] && . ~/.bashrc
. /etc/profile.d/caps_super_switch.sh

[[ -f ~/.xrandr-setup.sh ]] && . ~/.xrandr-setup.sh
