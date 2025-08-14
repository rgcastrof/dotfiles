#!/bin/bash

Volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | tr -d '%')

if [[ $Volume -gt 0 ]]; then
    pactl set-sink-volume @DEFAULT_SINK@ 0%
    dunstify -a "Volume" -r 9993 -u low "       Muted Volume"
elif [[ $Volume -eq 0 ]]; then
    dunstify -a "Volume" -r 9993 -u low "      Unmuted Volume"
    pactl set-sink-volume @DEFAULT_SINK@ 100%
fi
