#!/bin/sh

CURRENT_BRIGHTNESS=$(brightnessctl get)
if [ "$CURRENT_BRIGHTNESS" -eq "0" ]; then
    exit 0
fi

FOCUSED_WORKSPACE=$(swaymsg -t get_workspaces | jq -r '.[] | select(.focused==true).name')

if [ "$FOCUSED_WORKSPACE" = "10" ]; then
    # Let the native QML UI handle the swipe so it can animate the Numpad!
    exit 0
elif [ "$FOCUSED_WORKSPACE" != "1" ]; then
    pkill -USR1 -f wvkbd
    swaymsg kill
    swaymsg workspace 1
fi