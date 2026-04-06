#!/bin/sh
BL="/sys/class/backlight/lcd-backlight"
CUR=$(cat $BL/brightness)
MAX=$(cat $BL/max_brightness)

if [ "$CUR" -gt "0" ]; then
    # Turn screen off
    echo 0 > $BL/brightness
else
    # Turn screen on
    echo $MAX > $BL/brightness

    # Grab the IP and blast it directly to the physical screen
    IP=$(ip -4 addr show wlan0 | grep -o 'inet [0-9.]*' | awk '{print $2}')
    if [ -z "$IP" ]; then
        IP="Disconnected"
    fi
    echo -e "\n\n========================\nWi-Fi IP: $IP\n========================\n\n" > /dev/tty1
fi