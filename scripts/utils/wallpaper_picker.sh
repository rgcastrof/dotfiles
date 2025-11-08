#!/bin/bash
wallpaper=$(ls "$HOME/Pictures/Wallpapers" | dmenu -l 7 -p "select wallpaper:")

if [ -z "$wallpaper" ]; then
    dunstify -a "Wallpaper" -r 9993 -u low "Nothing was selected"
else
    feh --bg-scale "$HOME/Pictures/Wallpapers/$wallpaper"
    dunstify -a "Wallpaper" -r 9993 -u normal "wallpaper: $wallpaper set"
fi
