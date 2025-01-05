#!/bin/bash

ssid=$(nmcli -t -f active,ssid dev wifi | grep '^sim' | cut -d':' -f2)

if [ -z "$ssid" ]; then
    echo "󰤭"
else
    signalStrength=$(nmcli -t -f SSID,SIGNAL device wifi | grep "$ssid" | cut -d ':' -f2)
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
