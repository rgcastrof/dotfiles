#!/bin/bash

slstatus &
dunst &
picom -b
feh --bg-scale /home/goku/Pictures/Wallpapers/gradient_glow_blue.png
xautolock -time 15 -locker slock
