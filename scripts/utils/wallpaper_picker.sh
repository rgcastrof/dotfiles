#!/bin/bash
wallpaper=$(ls "$HOME/Pictures/Wallpapers" | dmenu -l 7 -p "select wallpaper:")

if [ -z "$wallpaper" ]; then
    notify-send "Nothing was selected"
else
    feh --bg-scale "$HOME/Pictures/Wallpapers/$wallpaper"
    sed -i "6s|[^/]*$|$wallpaper|" "$HOME/.config/suckless/dwm/autostart.sh"
    echo "wallpaper: $wallpaper set"
fi
