#!/bin/sh

CURRENT=$(brightnessctl get)

if [ "$CURRENT" -gt "0" ]; then
    echo "$CURRENT" > /tmp/brightness.save

    brightnessctl set 0
    swaymsg workspace 10

    swaymsg input type:touch events disabled
    echo "1" > /tmp/sleep_event
else
    SAVED=$(cat /tmp/brightness.save 2>/dev/null || echo "50%")

    brightnessctl set "$SAVED"

    swaymsg input type:touch events enabled
fi