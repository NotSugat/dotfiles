#!/bin/bash

# Apply wallpaper using wal
# wal -b 282738 -i ~/Wallpaper/Aesthetic2.png &&

# Start picom
sh ~/.screenlayout/dualmonitor.sh 

picom  &

firefox &

discord &

microsoft-edge-beta &

nm-applet &

xset r rate 250 140

env LD_PRELOAD=/usr/lib/spotify-adblock.so spotify --uri=%U &

