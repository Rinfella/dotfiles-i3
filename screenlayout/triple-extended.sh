#!/bin/sh
# Triple display: Laptop (left) + HDMI (center, primary) + DP-1 Type-C (right, portrait)
xrandr --output eDP --mode 1920x1080 --pos 0x138 --rotate normal \
       --output HDMI-A-0 --primary --mode 1920x1080 --pos 1920x0 --rotate normal \
       --output DisplayPort-1 --mode 1920x1080 --pos 3840x0 --rotate left \
       --output DisplayPort-0 --off
