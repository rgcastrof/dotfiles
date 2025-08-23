#!/bin/bash

battery=$(cat /sys/class/power_supply/BAT0/capacity)
charging_status=$(cat /sys/class/power_supply/BAT0/status)

if [ "$battery" -le 20 ] && [ $charging_status != "Charging" ]; then
	notify-send "󱃍 Low battery: $battery%" "Connect the charger"
fi
