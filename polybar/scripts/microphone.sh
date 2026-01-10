#!/bin/bash

# Get the default source (microphone)
get_default_source() {
    pactl info | grep "Default Source" | cut -d' ' -f3
}

# Get microphone volume
get_volume() {
    pactl get-source-volume @DEFAULT_SOURCE@ | grep -oP '\d+%' | head -1 | tr -d '%'
}

# Check if muted
is_muted() {
    pactl get-source-mute @DEFAULT_SOURCE@ | grep -q "yes"
}

# Display volume
display() {
    if is_muted; then
        echo "muted"
    else
        echo "$(get_volume)%"
    fi
}

# Handle actions
case "$1" in
    --toggle)
        pactl set-source-mute @DEFAULT_SOURCE@ toggle
        ;;
    --increase)
        pactl set-source-volume @DEFAULT_SOURCE@ +5%
        ;;
    --decrease)
        pactl set-source-volume @DEFAULT_SOURCE@ -5%
        ;;
    *)
        display
        
        # Listen for changes
        pactl subscribe | grep --line-buffered "source" | while read -r event; do
            display
        done
        ;;
esac
