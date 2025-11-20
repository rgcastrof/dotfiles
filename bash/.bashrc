# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Load system-wide bash completions for interactive shells
if [ -f /etc/profile.d/bash_completion.sh ]; then
    . /etc/profile.d/bash_completion.sh
fi

complete -F _command doas

prompt() {
	branch=$(git symbolic-ref --short HEAD 2>/dev/null)
	dirty=""
	staged=""

	if [ -n "$branch" ]; then
		branch="\[\e[1;36m\]git:\[\e[0;32m\]($branch)"
		! git diff --quiet 2>/dev/null || [ -n "$(git ls-files --others --exclude-standard)" ] && dirty="\[\e[31m\]*"
		! git diff --cached --quiet 2>/dev/null && staged="\[\e[32m\]+"
	fi

	git_prompt=$branch$dirty$staged
    PS1="\[\e[34m\]➜ \[\e[1;37m\]\W $git_prompt\[\e[0m\] "
}

HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoredups

PROMPT_COMMAND='history -a; prompt'

alias ls='ls --color=auto'
alias grep='grep --color=auto'

export EDITOR=nvim
export PATH="/opt/python3.12.11/bin:/sbin:/usr/sbin:/usr/local/go/bin:$HOME/.local/bin:$PATH"
