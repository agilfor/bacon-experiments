#!/bin/sh

# 1. HARDWARE CHECK: If the screen is off, ignore the raw hardware swipe!
CURRENT_BRIGHTNESS=$(brightnessctl get)
if [ "$CURRENT_BRIGHTNESS" -eq "0" ]; then
    exit 0
fi

# 2. Ask Sway what we are looking at
FOCUSED_WORKSPACE=$(swaymsg -t get_workspaces | jq -r '.[] | select(.focused==true).name')

if [ "$FOCUSED_WORKSPACE" = "10" ]; then
    # We are on the Lock Screen. Go back to whatever we were doing!
    swaymsg workspace back_and_forth
elif [ "$FOCUSED_WORKSPACE" != "1" ]; then
    # We are in an app. Hide the keyboard, kill the app, go home.
    pkill -USR1 -f wvkbd
    swaymsg kill
    swaymsg workspace 1
fi