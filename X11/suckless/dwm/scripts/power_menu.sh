#!/bin/bash

shutdown=" Shutdown"
reboot=" Reboot"
suspend="󰒲 Suspend"

# Variable passed to rofi
options="$shutdown\n$reboot\n$suspend"

chosen="$(echo -e "$options" | dmenu -i -p "Power-Menu " )"
case $chosen in
    $shutdown)
        doas /sbin/poweroff
        ;;
    $reboot)
        doas /sbin/reboot
        ;;
    $suspend)
        doas /bin/zzz
        ;;
esac
