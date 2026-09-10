#!/bin/sh
# Laptop (left) + DP-1 Type-C (right, portrait, primary)
xrandr --output eDP --mode 1920x1080 --pos 0x0 --rotate normal \
       --output HDMI-A-0 --off \
       --output DisplayPort-1 --primary --mode 1920x1080 --pos 1920x0 --rotate left \
       --output DisplayPort-0 --off
