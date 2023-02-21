#
# ~/.bash_profile
#

export EDITOR='emacsclient -c'
export VISUAL='emacsclient -c'

export PATH=$HOME/bin:$PATH:/sbin:$HOME/.local/bin:$PATH

ESP_GDB_BIN_PATH="/home/benjamin/.espressif/tools/riscv32-esp-elf-gdb/11.2_20220529/riscv32-esp-elf-gdb/bin"
if [ -d $ESP_GDB_BIN_PATH ]; then
    export PATH=$PATH:"$ESP_GDB_BIN_PATH"
fi

GOLANG_PATH="/usr/local/go/bin"
if [ -d $GOLANG_PATH ]; then
    export PATH=$PATH:"$GOLANG_PATH"
fi

export I_AM_LOCAL=y

[[ -f /etc/profile.d/caps_super_switch.sh ]] && \
    . /etc/profile.d/caps_super_switch.sh

[[ -f /home/benjamin/.xrandr-setup.sh ]] && \
    . /home/benjamin/.xrandr-setup.sh

[[ -f ~/.bashrc ]] && \
    . ~/.bashrc

if [ -f ~/.cargo/env ]; then
    source ~/.cargo/env
fi
