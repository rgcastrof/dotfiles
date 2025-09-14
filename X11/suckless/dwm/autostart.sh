#!/bin/bash

slstatus &
dunst &
picom -b
feh --bg-scale /home/goku/Pictures/Wallpapers/kde_mountain_dark.png
xautolock -time 15 -locker slock
