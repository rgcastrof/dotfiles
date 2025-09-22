#!/bin/bash

slstatus &
dunst &
picom -b
feh --bg-scale /home/goku/Pictures/Wallpapers/slackware.png
xautolock -time 15 -locker slock
