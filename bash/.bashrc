# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

my_prompt() {
  local git_branch=""
  local git_status=""

  # Verifica se estamos em um repositório Git e obtém o nome do branch
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    git_branch=" on \033[35m $(git symbolic-ref --short HEAD)\033[0m"

    # Status
    git_status=$(git status --porcelain)
    if [ -z "$git_status" ]; then
      git_status="\033[36m ✔\033[0m"
    else
      git_status="\033[31m ✗\033[0m"
    fi
  fi

  # Retorna o prompt personalizado
  PS1="\033[31m[\[\033[34m\]\u\033[35m@\033[33m\h \033[36m\W\033[32m]\033[0m$git_branch$git_status\n\[\033[32m\]❯\[\033[0m\] "
}

# Define o prompt customizado no Bash
PROMPT_COMMAND='my_prompt'


# Comandos Básicos
alias la='ls -a'
alias ll='ls -l'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ..='cd ..'


# Xbps
alias xu='sudo xbps-install -Su'
alias xi='sudo xbps-install -S'
alias xr='sudo xbps-remove -R'
alias xo='sudo xbps-remove -o'
alias xq='xbps-query -Rs'


# Volume
alias mute='pactl set-sink-volume @DEFAULT_SINK@ 0%'
alias unmute='pactl set-sink-volume @DEFAULT_SINK@ 100%'

eval "$(zoxide init bash)"
