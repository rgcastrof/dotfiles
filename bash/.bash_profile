# .bash_profile

# Get the aliases and functions
[ -f $HOME/.bashrc ] && . $HOME/.bashrc

export PATH="$PATH:/sbin:/usr/sbin"

# Automatically start xsession
# if [[ -z $DISPLAY ]] && [[ $(tty) == /dev/tty1 ]]; then
#     exec startx
# fi
