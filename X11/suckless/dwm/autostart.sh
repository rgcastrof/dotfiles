#!/bin/bash

slstatus &
dunst &
picom -b
feh --bg-scale /home/goku/Pictures/Wallpapers/slackware.jpg
xautolock -time 15 -locker slock
