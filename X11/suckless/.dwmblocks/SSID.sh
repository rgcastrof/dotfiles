#!/bin/bash

bssid=$(nmcli -t -f IN-USE,BSSID device wifi | grep '*' | tr -d '\\' | cut -d ':' -f2,3,4,5,6,7)

if [ -z "$bssid" ]; then
    echo "󰤭"
else
    signalStrength=$(nmcli -t -f BSSID,SIGNAL device wifi | tr -d '\\' | grep "$bssid" | cut -d ':' -f7)
    if [[ $signalStrength -le 100 && $signalStrength -gt 70 ]]; then
        echo "󰤨"
    elif [[ $signalStrength -le 70 && $signalStrength -gt 50 ]]; then
        echo "󰤥"
    elif [[ $signalStrength -le 50 && $signalStrength -gt 30 ]]; then
        echo "󰤢"
    elif [[ $signalStrength -le 30 && $signalStrength -gt 0 ]]; then
        echo "󰤟"
    fi
fi
