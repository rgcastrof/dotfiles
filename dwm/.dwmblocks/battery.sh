#!/bin/bash

battery=$(acpi | grep -oP '\d+(?=%)')
charging_status=$(acpi | awk '{ gsub(",", "", $3); print $3 }')

if [[ $charging_status == "Charging" ]]; then
    echo "${battery}% carregando"
else
    echo "${battery}%"
fi
