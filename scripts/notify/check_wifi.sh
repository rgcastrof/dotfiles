#!/bin/bash


ping -q -w 1 -c 1 8.8.8.8 > /dev/null

if [ $? -ne 0 ]; then
	notify-send "󰖪 Not connected to the internet"
fi
