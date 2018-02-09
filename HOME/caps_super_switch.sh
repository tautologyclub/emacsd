# /etc/profile.d/caps_super_switch.sh

# Set US keyboard layout as standard, Swedish as secondary and toggle by
# holding down both shifts, also switch caps and super keys
setxkbmap -option caps:super
setxkbmap -layout us,se
setxkbmap -option 'grp:shifts_toggle'
