#!/bin/bash

# Obtém o volume atual
VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | tr -d '%')
# Ícone e texto condicional

if [[ $VOLUME -gt 95 ]]; then
    status="--------------------"
elif [[ $VOLUME -le 95 && $VOLUME -gt 90 ]]; then
    status="-------------------"
elif [[ $VOLUME -le 90 && $VOLUME -gt 85 ]]; then
    status="------------------"
elif [[ $VOLUME -le 85 && $VOLUME -gt 80 ]]; then
    status="-----------------"
elif [[ $VOLUME -le 80 && $VOLUME -gt 75 ]]; then
    status="----------------"
elif [[ $VOLUME -le 75 && $VOLUME -gt 70 ]]; then
    status="---------------"
elif [[ $VOLUME -le 70 && $VOLUME -gt 65 ]]; then
    status="--------------"
elif [[ $VOLUME -le 65 && $VOLUME -gt 60 ]]; then
    status="-------------"
elif [[ $VOLUME -le 60 && $VOLUME -gt 55 ]]; then
    status="------------"
elif [[ $VOLUME -le 55 && $VOLUME -gt 50 ]]; then
    status="-----------"
elif [[ $VOLUME -le 50 && $VOLUME -gt 45 ]]; then
    status="----------"
elif [[ $VOLUME -le 45 && $VOLUME -gt 40 ]]; then
    status="---------"
elif [[ $VOLUME -le 40 && $VOLUME -gt 35 ]]; then
    status="--------"
elif [[ $VOLUME -le 35 && $VOLUME -gt 30 ]]; then
    status="-------"
elif [[ $VOLUME -le 30 && $VOLUME -gt 25 ]]; then
    status="------"
elif [[ $VOLUME -le 25 && $VOLUME -gt 20 ]]; then
    status="-----"
elif [[ $VOLUME -le 20 && $VOLUME -gt 15 ]]; then
    status="----"
elif [[ $VOLUME -le 15 && $VOLUME -gt 10 ]]; then
    status="---"
elif [[ $VOLUME -le 10 && $VOLUME -gt 5 ]]; then
    status="--"
elif [[ $VOLUME -le 5 && $VOLUME -gt 0 ]]; then
    status="-"
fi
# Envia a notificação com substituição (usando uma ID constante)
dunstify -a "Volume" -r 9993 -u low " 󰝝 $status $VOLUME%"

