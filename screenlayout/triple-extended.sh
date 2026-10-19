#!/bin/bash
# Triple display: Laptop (leftmost) + HDMI (center, primary) + DP-1 Type-C (rightmost, portrait)
set -e

if ! xrandr | grep -q "^DisplayPort-1 connected"; then
    notify-send -u normal "Screen Layout" "DP-1 (Type-C) not connected, cannot apply triple layout"
    exit 1
fi

if ! xrandr | grep -q "^HDMI-A-0 connected"; then
    notify-send -u normal "Screen Layout" "HDMI not connected, cannot apply triple layout"
    exit 1
fi

# Pass 1: bring up all outputs without rotation to establish the canvas
xrandr --output eDP --mode 1920x1080 --pos 0x0 --rotate normal \
       --output HDMI-A-0 --primary --mode 1920x1080 --pos 1920x0 --rotate normal \
       --output DisplayPort-1 --auto --pos 3840x0 --rotate normal \
       --output DisplayPort-0 --off

sleep 0.5

# Pass 2: apply portrait rotation on DP-1
xrandr --output DisplayPort-1 --rotate left
