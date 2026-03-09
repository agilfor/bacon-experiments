#!/bin/sh

# Ask Sway which workspace is currently active
FOCUSED_WORKSPACE=$(swaymsg -t get_workspaces | jq -r '.[] | select(.focused==true).name')

# If the active workspace is NOT "1" (the Home Screen), then we are in an app.
if [ "$FOCUSED_WORKSPACE" != "1" ]; then
    # Kill the app and snap back to the Home Screen
    swaymsg kill
    swaymsg workspace 1
fi