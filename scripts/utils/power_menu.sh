#!/bin/bash

shutdown=" Shutdown"
reboot=" Reboot"
suspend="󰒲 Suspend"

# Variable passed to rofi
options="$shutdown\n$reboot\n$suspend\n"

chosen="$(echo -e "$options" | dmenu -l 3 -i -p "Power-Menu:" )"
case $chosen in
    $shutdown)
		doas shutdown -P -h now
        ;;
    $reboot)
		doas shutdown -r now
        ;;
    $suspend)
		doas sh -c "echo mem > /sys/power/state"
        ;;
esac
