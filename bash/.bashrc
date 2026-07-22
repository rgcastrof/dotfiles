[[ $PS1 &&
  ! ${BASH_COMPLETION_VERSINFO:-} &&
  -f /usr/share/bash-completion/bash_completion ]] &&
    . /usr/share/bash-completion/bash_completion

complete -F _command doas

HISTSIZE=10000
HISTFILESIZE=20000

export EDITOR=nvim
export PATH=$HOME/.local/bin:${PATH}

alias ls='ls --color=auto'
alias nvm-init='source ~/.nvm-init.sh'

git_branch() {
	local branch
	branch=$(git branch --show-current 2>/dev/null)
	[ ! -z "$branch" ] && echo -e "\001\e[0;35m\002[$branch] "
}

prompt_status() {
	if [ $? -eq 0 ]; then
		echo -e "\001\e[0;32m\002✔"
	else
		echo -e "\001\e[0;31m\002✘"
	fi
}

PS1="\$(prompt_status) \[\e[0;34m\]\u:\[\e[0;33m\]\W \$(git_branch)\[\e[0;33m\]-\[\e[0m\]> "

