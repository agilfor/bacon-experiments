#!/bin/sh

FOCUSED_WORKSPACE=$(swaymsg -t get_workspaces | jq -r '.[] | select(.focused==true).name')

if [ "$FOCUSED_WORKSPACE" != "1" ]; then
    # 1. Force the keyboard to HIDE (Signal USR1)
    pkill -USR1 -f wvkbd
    
    # 2. Kill the app and snap back to the Home Screen
    swaymsg kill
    swaymsg workspace 1
fi