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
    PS1="\[\e[34m\]\w $git_prompt\n\[\e[1;37m\]λ \[\e[0m\]"
}

HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoredups

PROMPT_COMMAND='history -a; prompt'

alias ls='ls --color=auto'
alias grep='grep --color=auto'

export EDITOR=nvim
export GOPATH="$HOME"
export JAVA_HOME=/usr/lib64/java
export PATH="$HOME/.local/bin:$JAVA_HOME/bin:/bin:/sbin:/usr/sbin:$PATH"

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
