#!/bin/bash

slstatus &
dunst &
picom -b
xautolock -time 15 -locker slock &
feh --bg-scale "$HOME/Pictures/Wallpapers/slackware_ascii.png"
