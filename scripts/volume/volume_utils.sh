#!/bin/bash

get_volume() {
	pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}'
}

is_muted() {
	mute=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')
	[[ "$mute" == "yes" ]]
}

notify() {
	local vol="$1"
	local muted="$2"

	msg="Volume $vol"
	[[ $muted == "yes" ]] && msg="$msg (muted)"
	dunstify -a "Volume" -r 9993 -u low "$msg"
}
