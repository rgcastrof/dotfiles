#!/bin/bash

DIR="/home/goku/Pictures/Screenshots/"

mkdir -p "$DIR"

current=$(date +%Y-%m-%d_%H-%M-%S).png
name="screenshot_$current"
file="$DIR/$name"

/usr/bin/maim -s "$file"

if [ -f "$file" ]; then
    notify-send "Screenshot ${current} taken successfully!"
fi

