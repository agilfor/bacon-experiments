#!/bin/sh

# Ask Sway if the Control Center is currently visible on the focused workspace
IS_VISIBLE=$(swaymsg -t get_tree | jq -e '.. | select(.name? == "ControlCenter" and .visible? == true)')

if [ -n "$IS_VISIBLE" ]; then
    # It is visible. Hide it back to the scratchpad.
    swaymsg '[title="ControlCenter"] move to scratchpad'
else
    # It is hidden. Bring it to the current workspace and put it in the top right.
    # Note: If 'move position 680 20' is off-screen, change this to 'move position center' for now!
    swaymsg '[title="ControlCenter"] move to workspace current'
    swaymsg '[title="ControlCenter"] floating enable'
    swaymsg '[title="ControlCenter"] move position center'
fi