#!/bin/sh
# Extends the screen to the right of the laptop screen.
xrandr --output eDP --mode 1920x1080 --pos 0x138 --rotate normal --output HDMI-A-0 --primary --mode 1920x1080 --pos 1920x0 --rotate normal --output DisplayPort-0 --off --output DisplayPort-1 --off
