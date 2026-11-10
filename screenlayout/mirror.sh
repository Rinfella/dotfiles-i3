#!/bin/bash
set -euo pipefail

# Mirror laptop screen to all connected external displays
xrandr --output eDP --primary --mode 1920x1080 --pos 0x0 --rotate normal

# Mirror HDMI-A-0 to all connected displays (if connected)
if xrandr | grep -q "^HDMI-A-0 connected"; then
    xrandr --output HDMI-A-0 --mode 1920x1080 --pos 0x0 --rotate normal
fi

# Mirror DisplayPort-1 to all connected displays (if connected)
if xrandr | grep -q "^DisplayPort-1 connected"; then
    xrandr --output DisplayPort-1 --mode 1920x1080 --pos 0x0 --rotate normal
fi

# Turn off DisplayPort-0
xrandr --output DisplayPort-0 --off

