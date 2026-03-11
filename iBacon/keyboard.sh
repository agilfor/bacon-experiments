#!/bin/sh

CURRENT_BRIGHTNESS=$(brightnessctl get)
if [ "$CURRENT_BRIGHTNESS" -eq "0" ]; then
    exit 0
fi

FOCUSED_WORKSPACE=$(swaymsg -t get_workspaces | jq -r '.[] | select(.focused==true).name')

if [ "$FOCUSED_WORKSPACE" != "1" ]; then
    pkill -34 -f wvkbd
fi