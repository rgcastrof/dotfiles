#!/bin/bash

bssid=$(nmcli -t -f IN-USE,BSSID device wifi | grep '*' | tr -d '\\' | cut -d ':' -f2,3,4,5,6,7)
# signal=$(nmcli -t -f IN-USE,SIGNAL dev wifi | grep "*" | tr -d "*:")
ssid=$(nmcli -t -f IN-USE,SSID device wifi | grep "*" | tr -d "*:")

if [ -z "$bssid" ]; then
    echo "󰘊 desconectado "
else
    echo "󰘊 $ssid "
fi

#if [ -z "$bssid" ]; then
#    echo "󰤭  "
#else
#    signalStrength=$(nmcli -t -f BSSID,SIGNAL device wifi | tr -d '\\' | grep "$bssid" | cut -d ':' -f7)
#    if [[ $signalStrength -le 100 && $signalStrength -gt 70 ]]; then
#        echo "󰤨 $signal "
#    elif [[ $signalStrength -le 70 && $signalStrength -gt 50 ]]; then
#        echo "󰤥 $signal "
#    elif [[ $signalStrength -le 50 && $signalStrength -gt 30 ]]; then
#        echo "󰤢 $signal "
#    elif [[ $signalStrength -le 30 && $signalStrength -gt 0 ]]; then
#        echo "󰤟 $signal "
#    fi
#fi
