#!/bin/sh
# DP-1 Type-C monitor only (portrait), laptop closed/off
xrandr --output eDP --off \
       --output HDMI-A-0 --off \
       --output DisplayPort-1 --primary --mode 1920x1080 --pos 0x0 --rotate left \
       --output DisplayPort-0 --off
