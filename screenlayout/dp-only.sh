#!/bin/bash
# DP-1 Type-C monitor only (portrait), laptop closed/off
set -e

if ! xrandr | grep -q "^DisplayPort-1 connected"; then
    notify-send -u normal "Screen Layout" "DP-1 (Type-C) not connected"
    exit 1
fi

xrandr --output eDP --off \
       --output HDMI-A-0 --off \
       --output DisplayPort-1 --primary --auto --pos 0x0 --rotate normal \
       --output DisplayPort-0 --off

sleep 0.5

xrandr --output DisplayPort-1 --rotate left
