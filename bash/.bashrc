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
    git_branch=" on \e[35m $(git symbolic-ref --short HEAD)\e[0m"

    # Status
    git_status=$(git status --porcelain)
    if [ -z "$git_status" ]; then
      git_status="\e[36m ✔\e[0m"
    else
      git_status="\e[31m ✗\e[0m"
    fi
  fi

  # Retorna o prompt personalizado
  PS1="\e[1;35m╭─\e[1;31m(\e[1;34m\u\e[1;35m@\e[1;33m\h\e[1;31m)\e[1;35m─\e[1;32m(\e[1;35m\w\e[0m$git_branch$git_status\e[1;32m)\n\e[1;35m╰─\[\e[1;32m\]❯\[\e[0m\] "
}

# Define o prompt customizado no Bash
PROMPT_COMMAND='my_prompt'


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
