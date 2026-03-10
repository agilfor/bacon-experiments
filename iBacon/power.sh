#!/bin/sh

# Read the current hardware backlight level
CURRENT=$(brightnessctl get)

if [ "$CURRENT" -gt "0" ]; then
    # 1. Screen is ON. We need to SLEEP.
    # Save the current brightness so we remember what it was
    echo "$CURRENT" > /tmp/brightness.save
    
    # Kill the backlight
    brightnessctl set 0
    swaymsg workspace 10
    
    # Disable the touchscreen so it ignores pocket-dials
    swaymsg input type:touch events disabled
else
    # 2. Screen is OFF. We need to WAKE.
    # Read the saved brightness (or default to 50% if the file is missing)
    SAVED=$(cat /tmp/brightness.save 2>/dev/null || echo "50%")
    
    # Restore the backlight
    brightnessctl set "$SAVED"
    
    # Re-enable the touchscreen
    swaymsg input type:touch events enabled
fi