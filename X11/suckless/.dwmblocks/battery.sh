#!/bin/bash

battery=$(acpi | grep -oP '\d+(?=%)')
charging_status=$(acpi | awk '{print $3}' | tr -d ',')

if [ "$charging_status" = "Charging" ]; then
    if [[ $battery -gt 80 ]]; then
        echo " 󱐋 "
    elif [[ $battery -le 80 && $battery -gt 60 ]]; then
        echo " 󱐋 "
    elif [[ $battery -le 60 && $battery -gt 40 ]]; then
        echo " 󱐋 "
    elif [[ $battery -le 40 && $battery -ge 20 ]]; then
        echo " 󱐋 "
    elif [[ $battery -lt 20 ]]; then
        echo " 󱐋 "
    fi
else
    if [[ $battery -gt 80 ]]; then
        echo "  "
    elif [[ $battery -le 80 && $battery -gt 60 ]]; then
        echo "  "
    elif [[ $battery -le 60 && $battery -gt 40 ]]; then
        echo "  "
    elif [[ $battery -le 40 && $battery -ge 20 ]]; then
        echo "  "
    elif [[ $battery -lt 20 ]]; then
        echo "  "
    fi
fi
