case $- in
    *i*) : ;;
    *) return ;;
esac

export HISTFILE=$HOME/.ksh_history
export HISTSIZE=20000

export EDITOR=nvim
set -o emacs
set -o ignoreeof

export PATH="/opt/python3.12.11/bin:/sbin:/usr/sbin:/usr/local/go/bin:$HOME/.local/bin:$PATH"

function git_status_prompt {
  branch=$(git symbolic-ref --short HEAD 2>/dev/null)

  if [ -z "$branch" ]; then
    print ""
    return
  fi

  if git diff --quiet 2>/dev/null; then
    dirty=""
  else
    dirty="*"
  fi

  if git diff --cached --quiet 2>/dev/null; then
    staged=""
  else
    staged="+"
  fi

  print "\033[32m ($branch)\033[33m$staged\033[31m$dirty\033[0m"
}

function prompt_command {
	if [ "$PWD" = "$HOME" ]; then
		dir="~"
	else
		dir=$(basename "$PWD")
	fi
  	print "\033[35m➜ \033[1;37m${dir}\033[0m$(git_status_prompt)"
}

PS1='$(prompt_command) '

alias ls='ls --color=auto'
alias grep='grep --color=auto'
