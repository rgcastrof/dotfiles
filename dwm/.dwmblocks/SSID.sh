#!/bin/bash

ssid=$(nmcli -t -f active,ssid dev wifi | grep '^sim' | cut -d':' -f2)

if [ -z "$ssid" ]; then
    echo "󰖪"
else
#  echo "${ssid}"
    echo "󰖩"
fi
