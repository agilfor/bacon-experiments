#!/bin/sh

FOCUSED_WORKSPACE=$(swaymsg -t get_workspaces | jq -r '.[] | select(.focused==true).name')

if [ "$FOCUSED_WORKSPACE" = "10" ]; then
    # 1. We are on the Lock Screen. Go back to whatever we were doing!
    swaymsg workspace back_and_forth
elif [ "$FOCUSED_WORKSPACE" != "1" ]; then
    # 2. We are in an app. Hide the keyboard, kill the app, go home.
    pkill -USR1 -f wvkbd
    swaymsg kill
    swaymsg workspace 1
fi