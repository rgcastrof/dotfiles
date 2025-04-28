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

my_prompt() {

    local git_branch=""
    local git_status=""

    # Verifica se estamos em um repositório Git e obtém o nome do branch
    if git rev-parse --is-inside-work-tree &>/dev/null; then
    git_branch="\[\e[32m\] \[\e[35m\]$(git symbolic-ref --short HEAD)\[\e[0m\]"

    # Status
    git_status=$(git status --porcelain)
    if [ -z "$git_status" ]; then
        git_status="\[\e[32m\] [\[\e[36m\]✔\[\e[32m\]]\[\e[0m\]\n"
        else
            git_status="\[\e[32m\] [\[\e[31m\]✗\[\e[32m\]]\[\e[0m\]\n"
        fi
    fi
    PS1="$git_branch$git_status[\[\e[34m\]\u\[\e[37m\]@\[\e[33m\]\h \[\e[35m\]\W\[\e[0m\]]\$ "
}

PROMPT_COMMAND='my_prompt'

# Comandos Básicos
alias la='ls -a'
alias l='ls -l'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ..='cd ..'


# Xbps
alias xu='doas xbps-install -Su'
alias xi='doas xbps-install -S'
alias xr='doas xbps-remove -R'
alias xo='doas xbps-remove -o'
alias xq='xbps-query -Rs'


# git
alias gi='git init'
alias gs='git status'
alias ga='git add'
alias gc='git commit'


# Volume
alias mute='pactl set-sink-volume @DEFAULT_SINK@ 0%'
alias unmute='pactl set-sink-volume @DEFAULT_SINK@ 100%'

eval "$(zoxide init bash)"

# Created by `pipx` on 2025-04-11 22:16:42
export PATH="$PATH:/home/owl/.local/bin"

fetch
