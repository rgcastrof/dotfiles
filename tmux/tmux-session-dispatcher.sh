#!/bin/sh

[ $# -eq 0 ] && selected="$(pipa)"

[ -z "$selected" ] && exit 0

selected_name="$(basename "$selected")"

if ! tmux has-session -t "$selected_name"; then
	tmux new-session -ds "$selected_name" -c "$selected"
fi

tmux switch-client -t "$selected_name"
