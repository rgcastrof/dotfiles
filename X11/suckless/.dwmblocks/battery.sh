#!/bin/bash

battery=$(acpi | grep -oP '\d+(?=%)')
charging_status=$(acpi | awk '{print $3}' | tr -d ',')

if [ "$charging_status" = "Charging" ]; then
    if [[ $battery -gt 95 ]]; then
        echo "[ 󰂅 $battery% ] "
    elif [[ $battery -le 95 && $battery -gt 90 ]]; then
        echo "[ 󰂋 $battery% ] "
    elif [[ $battery -le 90 && $battery -gt 80 ]]; then
        echo "[ 󰂊 $battery% ] "
    elif [[ $battery -le 80 && $battery -gt 70 ]]; then
        echo "[ 󰂊 $battery% ] "
    elif [[ $battery -le 70 && $battery -gt 60 ]]; then
        echo "[ 󰢞 $battery% ] "
    elif [[ $battery -le 60 && $battery -gt 50 ]]; then
        echo "[ 󰂉 $battery% ] "
    elif [[ $battery -le 50 && $battery -gt 40 ]]; then
        echo "[ 󰢝 $battery% ] "
    elif [[ $battery -le 40 && $battery -gt 30 ]]; then
        echo "[ 󰂈 $battery% ] "
    elif [[ $battery -le 30 && $battery -gt 20 ]]; then
        echo "[ 󰂇 $battery% ] "
    elif [[ $battery -le 20 && $battery -gt 10 ]]; then
        echo "[ 󰂆 $battery% ] "
    elif [[ $battery -le 10 ]]; then
        echo "[ 󰢜 $battery% ] "
    fi
else
    if [[ $battery -gt 90 ]]; then
        echo "[ 󰁹 $battery% ] "
    elif [[ $battery -le 90 && $battery -gt 80 ]]; then
        echo "[ 󰂂 $battery% ] "
    elif [[ $battery -le 80 && $battery -gt 70 ]]; then
        echo "[ 󰂁 $battery% ] "
    elif [[ $battery -le 70 && $battery -gt 60 ]]; then
        echo "[ 󰂀 $battery% ] "
    elif [[ $battery -le 60 && $battery -gt 50 ]]; then
        echo "[ 󰁿 $battery% ] "
    elif [[ $battery -le 50 && $battery -gt 40 ]]; then
        echo "[ 󰁾 $battery% ] "
    elif [[ $battery -le 40 && $battery -gt 30 ]]; then
        echo "[ 󰁽 $battery% ] "
    elif [[ $battery -le 30 && $battery -gt 20 ]]; then
        echo "[ 󰁼 $battery% ] "
    elif [[ $battery -le 20 && $battery -gt 10 ]]; then
        echo "[ 󰁻 $battery% ] "
    elif [[ $battery -le 10 ]]; then
        echo "[ 󰁺 $battery% ]"
    fi
fi
