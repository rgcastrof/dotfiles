#!/bin/bash

dwmblocks &
dunst &
nitrogen --restore
picom -b
xautolock -time 10 -locker slock
