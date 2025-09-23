# .bash_profile

# Get the aliases and functions
[ -f $HOME/.bashrc ] && . $HOME/.bashrc

export PATH="$PATH:/sbin:/usr/sbin"

"$HOME/.config/scripts/utils/initxng"

# Automatically start xsession
# if [[ -z $DISPLAY ]] && [[ $(tty) == /dev/tty1 ]]; then
#     exec startx
# fi
