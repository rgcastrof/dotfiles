#!/bin/bash

audio_output=$(pacmd list-sinks | grep active | awk '{print $3}')
volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | tr -d '%')

if [[ $audio_output == "<analog-output-headphones>" ]]; then
    if [[ $volume -ge 50 ]]; then
        echo "HIGH VOLUME"
    else
        echo ""
    fi
elif [[ $audio_output == "<analog-output-speaker>" ]]; then
    if [[ $volume -gt 100 ]]; then
        echo "HIGH VOLUME"
    elif [[ $volume -gt 70 && $volume -le 100 ]]; then
        echo " "
    elif [[ $volume -le 70 && $volume -gt 40 ]]; then
        echo ""
    elif [[ $volume -le 40 && $volume -gt 0 ]]; then
        echo ""
    elif [[ $volume -eq 0 ]]; then
        echo " "
    fi
fi
