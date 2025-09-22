#!/bin/bash

shutdown=" Shutdown"
reboot=" Reboot"
suspend="󰒲 Suspend"

# Variable passed to rofi
options="$shutdown\n$reboot\n$suspend\n"

chosen="$(echo -e "$options" | dmenu -l 7 -bw 3 -i -p "Power-Menu " )"
case $chosen in
    $shutdown)
		doas poweroff
        ;;
    $reboot)
		doas reboot
        ;;
    $suspend)
		doas sh -c "echo mem > /sys/power/state"
        ;;
esac
