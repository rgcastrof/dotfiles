#!/bin/bash

current=$(date +%Y-%m-%d_%H-%M-%S).png

/usr/bin/scrot -s /home/owl/Imagens/Screenshots/screenshot_$current

notify-send "Screenshot ${current} taken successfully!"
