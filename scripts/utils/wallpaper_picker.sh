#!/bin/bash
wallpaper=$(ls "$HOME/Pictures/Wallpapers" | dmenu -l 7 -p "select wallpaper:")

if [ -z "$wallpaper" ]; then
    dunstify -a "Wallpaper" -r 9993 -u low "Nothing was selected"
else
    feh --bg-scale "$HOME/Pictures/Wallpapers/$wallpaper"
    sed -i "6s|[^/]*$|$wallpaper|" "$HOME/.config/suckless/dwm/autostart.sh"
    dunstify -a "Wallpaper" -r 9993 -u normal "wallpaper: $wallpaper set"
fi
