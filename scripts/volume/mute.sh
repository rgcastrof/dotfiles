#!/bin/bash

source "$HOME/.config/scripts/volume/volume_utils.sh"

pactl set-sink-mute @DEFAULT_SINK@ toggle

vol=$(get_volume)
muted=$(is_muted && echo "yes" || echo "no")

notify "$vol" "$muted"
