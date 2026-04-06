#!/bin/sh
# Find the currently active TTY (usually outputs "tty1" or "tty2")
CURRENT=$(cat /sys/class/tty/tty0/active)

if [ "$CURRENT" = "tty1" ]; then
    chvt 2
else
    chvt 1
fi