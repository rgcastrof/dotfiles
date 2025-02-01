#!/bin/bash

bssid=$(nmcli -t -f IN-USE,BSSID device wifi | grep '*' | tr -d '\\' | cut -d ':' -f2,3,4,5,6,7)

if [ -z "$bssid" ]; then
    echo "wifi: disconnected"
else
    echo "wifi: connected"
fi
