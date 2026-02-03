case $- in
    *i*) : ;;
    *) return ;;
esac

export HISTFILE=$HOME/.ksh_history
export HISTSIZE=20000

export EDITOR=hx
set -o emacs
set -o ignoreeof

function git_status_prompt {
  branch=$(git symbolic-ref --short HEAD 2>/dev/null)
  dirty=""
  staged=""

  if [ -n "$branch" ]; then
    branch="\033[1;36m\]git:\033[0;32m\]($branch)"
    ! git diff --quiet 2>/dev/null || [ -n "$(git ls-files --others --exclude-standard)" ] && dirty="\033[31m\]*"
    ! git diff --cached --quiet 2>/dev/null && staged="\033[32m\]+"
  fi

  print "${branch}${dirty}${staged}"
}

function prompt_command {
	if [ "$PWD" = "$HOME" ]; then
		dir="~"
	else
		dir="$PWD"
	fi
    print "\033[34m${dir} $(git_status_prompt)\n\033[1;37m󰘧\033[0m "
}

PS1='$(prompt_command)'
