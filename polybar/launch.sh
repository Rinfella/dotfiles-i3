#!/usr/bin/env bash

# Terminate already running bar instances
polybar-msg cmd quit 2>/dev/null || killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Automatically detect and launch on all connected monitors
if type "xrandr" >/dev/null; then
  # Use an associative array to track which screen offsets (X/Y coordinates) already have a bar
  declare -A used_offsets

  # Detect primary monitor, default to first connected monitor if not set
  primary_monitor=$(xrandr --query | grep " primary" | cut -d" " -f1)
  if [[ -z "$primary_monitor" ]]; then
    primary_monitor=$(xrandr --query | grep " connected" | cut -d" " -f1 | head -n 1)
  fi

  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    # Get the geometry (e.g., 1920x1080+0+0) for this specific monitor
    geometry=$(xrandr --query | grep "^$m" | grep -o -E "[0-9]+x[0-9]+\+[0-9]+\+[0-9]+")
    
    # Extract just the offset coordinates (e.g., +0+0)
    offset=$(echo "$geometry" | grep -o -E "\+[0-9]+\+[0-9]+")

    if [[ -n "$offset" ]]; then
      # If this offset is already in our array, it means screens are mirrored. Skip launching.
      if [[ -n "${used_offsets[$offset]}" ]]; then
        echo "Monitor $m shares offset $offset with ${used_offsets[$offset]} (Mirrored). Skipping Polybar."
        continue
      fi
      # Mark this coordinate space as populated
      used_offsets[$offset]=$m
    fi

    # Launch Polybar (main with tray on primary, secondary without tray on others)
    if [[ "$m" == "$primary_monitor" ]]; then
      MONITOR=$m polybar main -c ~/.config/polybar/config.ini &
    else
      MONITOR=$m polybar secondary -c ~/.config/polybar/config.ini &
    fi
  done
else
  polybar main -c ~/.config/polybar/config.ini &
fi
