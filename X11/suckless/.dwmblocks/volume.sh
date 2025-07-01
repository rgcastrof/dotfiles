#!/bin/bash

audio_output=$(pacmd list-sinks | grep active | awk '{print $3}')
volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | tr -d '%')

#if [[ $audio_output == "<analog-output-headphones>" ]]; then
#    echo "headphones: $volume%  "
#elif [[ $audio_output == "<analog-output-speaker>" ]]; then
#    echo "speakers: $volume%  "
#fi

if [[ $audio_output == "<analog-output-headphones>" ]]; then
        echo "[   $volume% ] "
elif [[ $audio_output == "<analog-output-speaker>" ]]; then
    if [[ $volume -gt 70 ]]; then
        echo "[   $volume% ] "
    elif [[ $volume -le 70 && $volume -gt 40 ]]; then
        echo "[   $volume% ] "
    elif [[ $volume -le 40 && $volume -gt 0 ]]; then
        echo "[   $volume% ] "
    elif [[ $volume -eq 0 ]]; then
        echo "[   $volume% ] "
    fi
fi
