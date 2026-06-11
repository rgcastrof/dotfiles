#!/bin/sh

[ $# -eq 0 ] && selected="$(pipa)"

[ -z "$selected" ] && exit 0

selected_name="$(basename "$selected" | tr '.' '_')"

if ! tmux has-session -t "$selected_name" 2>/dev/null; then
	tmux new-session -ds "$selected_name" -c "$selected"
fi

if [ -z "$TMUX" ]; then
	tmux attach-session -t "$selected_name"
else
	tmux switch-client -t "$selected_name"
fi
