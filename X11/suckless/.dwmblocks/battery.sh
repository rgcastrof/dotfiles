#!/bin/bash

battery=$(acpi | grep -oP '\d+(?=%)')
charging_status=$(acpi | awk '{print $3}' | tr -d ',')

if [ "$charging_status" = "Charging" ]; then
    echo "battery: $battery% "
else
    echo "battery: $battery%"
fi
