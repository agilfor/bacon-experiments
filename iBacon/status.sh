#!/bin/sh

while true; do
    # Read the hardware clock
    TIME=$(date +"%H:%M")
    
    # Read the battery directly from the kernel (grabs the first battery it finds)
    BAT=$(cat /sys/class/power_supply/bms/capacity 2>/dev/null || cat /sys/class/power_supply/battery/capacity 2>/dev/null)
    
    # Print the iOS-style string to swaybar
    echo "$TIME            $BAT%"
    
    # Sleep for 10 seconds so we don't chew up CPU cycles
    sleep 10
done