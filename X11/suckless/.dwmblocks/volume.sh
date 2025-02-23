#!/bin/bash

audio_output=$(pacmd list-sinks | grep active | awk '{print $3}')
volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | tr -d '%')

if [[ $audio_output == "<analog-output-headphones>" ]]; then
    echo "headphones: $volume%  "
elif [[ $audio_output == "<analog-output-speaker>" ]]; then
    echo "speakers: $volume%  "
fi
