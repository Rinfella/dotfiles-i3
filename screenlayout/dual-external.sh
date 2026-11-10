#!/bin/bash
# Dual external landscape: HDMI (left, primary) + DP-1 Type-C (right, landscape), laptop closed/off
set -euo pipefail

if ! xrandr | grep -q "^DisplayPort-1 connected"; then
    notify-send -u normal "Screen Layout" "DP-1 (Type-C) not connected, cannot apply dual-external layout"
    exit 1
fi

if ! xrandr | grep -q "^HDMI-A-0 connected"; then
    notify-send -u normal "Screen Layout" "HDMI not connected, cannot apply dual-external layout"
    exit 1
fi

xrandr --output eDP --off \
       --output HDMI-A-0 --primary --mode 1920x1080 --pos 0x0 --rotate normal \
       --output DisplayPort-1 --auto --pos 1920x0 --rotate normal \
       --output DisplayPort-0 --off

