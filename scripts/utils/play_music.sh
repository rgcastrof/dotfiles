#!/bin/bash

MUS_DIR=/home/goku/Músicas
music=$(ls $MUS_DIR | dmenu -l 7 -bw 3 -p "play:")

alacritty -e mpv --no-video "$MUS_DIR/$music"
