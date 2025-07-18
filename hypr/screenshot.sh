#!/bin/bash
timestamp=$(date +'%Y%m%d-%H%M%S')
mkdir -p "$HOME/Pictures/Screenshots"
grim -g "$(slurp)" "$HOME/Pictures/Screenshots/$timestamp.png" && wl-copy < "$HOME/Pictures/Screenshots/$timestamp.png"
