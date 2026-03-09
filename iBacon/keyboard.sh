#!/bin/sh

# Ask Sway what we are looking at
FOCUSED_WORKSPACE=$(swaymsg -t get_workspaces | jq -r '.[] | select(.focused==true).name')

# If we are NOT on the Home Screen (Workspace 1), allow the keyboard
if [ "$FOCUSED_WORKSPACE" != "1" ]; then
    # Signal 34 (SIGRTMIN) is the true "Toggle" command!
    pkill -34 -f wvkbd
fi