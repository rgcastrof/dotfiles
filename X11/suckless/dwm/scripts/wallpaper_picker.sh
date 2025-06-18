#!/bin/bash
wallpaper=$(ls "$HOME/Imagens/Wallpapers" | dmenu -l 7 -bw 3 -p "select:")

if [ -z "$wallpaper" ]; then
    echo "Nothing was selected"
else
    feh --bg-scale "$HOME/Imagens/Wallpapers/$wallpaper"
    echo "wallpaper: $wallpaper set"
fi
