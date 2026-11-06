#!/bin/bash
set -euo pipefail

# Mirror laptop screen to all connected external displays.
# Use direct xrandr commands to avoid eval security risk
xrandr --output eDP --mode 1920x1080 --pos 0x0 --rotate normal

HDMI_ON=false
if xrandr | grep -q "^HDMI-A-0 connected"; then
    HDMI_ON=true
fi

DP_ON=false
if xrandr | grep -q "^DisplayPort-1 connnected"; then
    DP_ON=true
fi

# Apply monitor configurations
if [[ "$HDMI_ON" == "true" ]]; then
    xrandr --output HDMI-A-0 --primary --mode 1920x1080 --pos 0x0 --rotate normal
else
    xrandr --output HDMI-A-0 --off
fi

if [[ "$DP_ON" == "true" ]]; then
    xrandr --output DisplayPort-1 --mode 1920x1080 --pos 0x0 --rotate normal
else
    xrandr --output DisplayPort-1 --off
fi

xrandr --output DisplayPort-0 --off
