#!/bin/bash

source "$HOME/.config/scripts/volume/volume_utils.sh"

pactl set-sink-volume @DEFAULT_SINK@ +5%

vol=$(get_volume)
muted=$(is_muted && echo "yes" || echo "no")

notify "$vol" "$muted"
