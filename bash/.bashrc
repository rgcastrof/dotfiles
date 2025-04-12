# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


PS1='[\u@\h \W]\$ '

# Comandos Básicos
alias la='ls -a'
alias ll='ls -l'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ..='cd ..'
alias g='gnome-text-editor'


# Xbps
alias xu='doas xbps-install -Su'
alias xi='doas xbps-install -S'
alias xr='doas xbps-remove -R'
alias xo='doas xbps-remove -o'
alias xq='xbps-query -Rs'


# Volume
alias mute='pactl set-sink-volume @DEFAULT_SINK@ 0%'
alias unmute='pactl set-sink-volume @DEFAULT_SINK@ 100%'

eval "$(zoxide init bash)"

# Created by `pipx` on 2025-04-11 22:16:42
export PATH="$PATH:/home/rogerio/.local/bin"
