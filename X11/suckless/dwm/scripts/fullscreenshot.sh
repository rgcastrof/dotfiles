#!/bin/bash

DIR="/home/goku/Imagens/Screenshots/"

mkdir -p "$DIR"

current=$(date +%Y-%m-%d_%H-%M-%S).png
name="full-screenshot_$current"
file="$DIR/$name"

/usr/bin/maim "$file"

if [ -f "$file" ]; then
    notify-send "Full screenshot ${current} taken successfully!"
fi

