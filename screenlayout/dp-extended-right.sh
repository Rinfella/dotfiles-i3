#!/bin/bash
# Laptop (left) + DP-1 Type-C (right, portrait, primary)
set -e

if ! xrandr | grep -q "^DisplayPort-1 connected"; then
    notify-send -u normal "Screen Layout" "DP-1 (Type-C) not connected"
    exit 1
fi

xrandr --output eDP --mode 1920x1080 --pos 0x0 --rotate normal \
       --output HDMI-A-0 --off \
       --output DisplayPort-1 --primary --auto --pos 1920x0 --rotate normal \
       --output DisplayPort-0 --off

sleep 0.5

xrandr --output DisplayPort-1 --rotate left
