#!/bin/sh
# Mirror laptop screen to all connected external displays.
cmd="xrandr --output eDP --mode 1920x1080 --pos 0x0 --rotate normal"

if xrandr | grep -q "^HDMI-A-0 connected"; then
    cmd="$cmd --output HDMI-A-0 --primary --mode 1920x1080 --pos 0x0 --rotate normal"
else
    cmd="$cmd --output HDMI-A-0 --off"
fi

if xrandr | grep -q "^DisplayPort-1 connected"; then
    cmd="$cmd --output DisplayPort-1 --mode 1920x1080 --pos 0x0 --rotate normal"
else
    cmd="$cmd --output DisplayPort-1 --off"
fi

cmd="$cmd --output DisplayPort-0 --off"

eval "$cmd"
