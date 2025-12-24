#!/bin/bash

shutdown=" Shutdown"
reboot=" Reboot"
suspend="󰿅 Logout"

options="$shutdown\n$reboot\n$suspend\n"

chosen="$(echo -e "$options" | wmenu -f "JetBrains Mono NerdFont 11" -l 3 -p "Power-Menu:" )"
case $chosen in
    $shutdown)
		doas shutdown -P -h now
        ;;
    $reboot)
		doas shutdown -r now
        ;;
    $suspend)
		swaymsg exit
        ;;
esac
