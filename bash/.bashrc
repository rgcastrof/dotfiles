# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Load system-wide bash completions for interactive shells
if [ -f /etc/profile.d/bash_completion.sh ]; then
    . /etc/profile.d/bash_completion.sh
fi

complete -F _command doas

prompt() {
    local git_branch=""
    local git_status=""

    if git rev-parse --is-inside-work-tree &>/dev/null; then
        git_branch="\[\e[1;35m\]git:(\[\e[1;31m\]$(git symbolic-ref --short HEAD)\[\e[1;35m\])\[\e[0m\]"

    git_status=$(git status --porcelain 2>/dev/null)
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

alias ls='ls --color=auto'
alias grep='grep --color=auto'

export EDITOR=nvim
export PATH="/opt/python3.12.11/bin:/sbin:/usr/sbin:/usr/local/go/bin:$HOME/.local/bin:$PATH"
