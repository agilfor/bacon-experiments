#!/bin/sh

IS_VISIBLE=$(swaymsg -t get_tree | jq -e '.. | select(.name? == "ControlCenter" and .visible? == true)')

if [ -n "$IS_VISIBLE" ]; then
    swaymsg '[title="ControlCenter"] move to scratchpad'
else
    swaymsg '[title="ControlCenter"] move to workspace current'
    swaymsg '[title="ControlCenter"] floating enable'
    # Snap it to the top left so it covers everything!
    swaymsg '[title="ControlCenter"] move position 0 0'
fi