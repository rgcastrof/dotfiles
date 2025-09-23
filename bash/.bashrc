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

prompt() {
    local git_branch=""
    local git_status=""

    if git rev-parse --is-inside-work-tree &>/dev/null; then
        git_branch="\[\e[1;35m\]git:(\[\e[1;31m\]$(git symbolic-ref --short HEAD)\[\e[1;35m\])\[\e[0m\]"

    git_status=$(git status --porcelain)
    if [ -z "$git_status" ]; then
        git_status="\[\e[32m\]✔ "
        else
            git_status="\[\e[31m\]✗ "
        fi
    fi
    PS1="\[\e[33m\]➜ \[\e[1;37m\]\W $git_branch$git_status\[\e[0m\]"
}

HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoredups

PROMPT_COMMAND='history -a; prompt'

# ALIAS
alias la='ls -a'
alias l='ls -l'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ..='cd ..'

# Created by `pipx` on 2025-05-01 18:24:03
export PATH="$PATH:/home/goku/.local/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
