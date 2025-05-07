#!/bin/bash

current=$(date +%Y-%m-%d_%H-%M-%S).png

/usr/bin/scrot /home/falcon/Imagens/Screenshots/full-screenshot_$current

notify-send "Full screenshot ${current} taken successfully!"
