#!/bin/bash

volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | tr -d '%')

if [[ $volume -gt 100 ]]; then
    echo " VOLUME ALTO"
elif [[ $volume -gt 70 && $volume -le 100 ]]; then
    echo "  "
elif [[ $volume -le 70 && $volume -gt 40 ]]; then
    echo "  "
elif [[ $volume -le 40 && $volume -gt 0 ]]; then
    echo "  "
elif [[ $volume -eq 0 ]]; then
    echo "  "
fi

