# check if shell is interactive
case $- in
    *i*) : ;;
    *) return ;;
esac

# colors
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
CYAN="\033[36m"
WHITE="\033[37m"
RESET="\033[0m"

export EDITOR=nvim
export HISTFILE=$HOME/.ksh_history
export HISTSIZE=20000
export JAVA_HOME=/usr/local/jdk-17
export PATH="$JAVA_HOME/bin:$HOME/.local/bin:$HOME/go/bin:${PATH}"

set -o emacs
set -o ignoreeof

function get_cwd {
	local dir=""
	case "$PWD" in
		$HOME) dir="~" ;;
		$HOME/*) dir="~${PWD#$HOME}" ;;
		*) dir="${PWD}" ;;
	esac
	echo "${BLUE}${dir}"
}

function git_status {
  branch=$(git symbolic-ref --short HEAD 2>/dev/null)
  dirty=""
  staged=""

  if [ -n "$branch" ]; then
    branch="${CYAN}git:${GREEN}(${branch})"
    ! git diff --quiet 2>/dev/null || [ -n "$(git ls-files --others --exclude-standard)" ] && dirty="${RED}*"
    ! git diff --cached --quiet 2>/dev/null && staged="${GREEN}+"
	echo "${branch}${dirty}${staged} "
  else
	echo ""
  fi
}

if [ "$(id -u)" -eq 0 ]; then
	# root
	PS1='$(get_cwd)\n${RED}# ${RESET}'
else
	PS1='${RED}\u${RESET}:$(get_cwd) $(git_status)${YELLOW}$ ${RESET}'
fi

alias ls='colorls -G'
