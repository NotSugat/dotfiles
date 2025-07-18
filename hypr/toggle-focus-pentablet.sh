#!/bin/bash

target_class="PenTablet"
rule="windowrulev2 = nofocus, class:^(${target_class})$"

# Function to remove nofocus rule
remove_nofocus_rule() {
    hyprctl keyword windowrulev2 "unset"
}

# Function to reapply nofocus rule
reapply_nofocus_rule() {
    hyprctl keyword windowrulev2 "$rule"
}

# Get the focused window class
focused_class=$(hyprctl activewindow -j | jq -r '.class')

if [[ "$focused_class" == "$target_class" ]]; then
    # Focus previous window
    hyprctl dispatch focuswindow "address:-1"
else
    # Temporarily remove the rule
    remove_nofocus_rule

    # Wait a tiny bit to ensure rule is cleared
    sleep 0.1

    # Focus the PenTablet window
    hyprctl dispatch focuswindow "class:^(${target_class})$"

    # Wait a bit to ensure focus happens
    sleep 0.2

    # Reapply the rule
    reapply_nofocus_rule
fi

