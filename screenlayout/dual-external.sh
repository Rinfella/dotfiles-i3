#!/bin/sh
# Dual external: HDMI (left, primary) + DP-1 Type-C (right, portrait), laptop closed/off
xrandr --output eDP --off \
       --output HDMI-A-0 --primary --mode 1920x1080 --pos 0x0 --rotate normal \
       --output DisplayPort-1 --mode 1920x1080 --pos 1920x0 --rotate left \
       --output DisplayPort-0 --off
