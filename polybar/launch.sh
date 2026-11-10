#!/usr/bin/env bash

# Deduplication guard: avoid spawning duplicate bars on the same offset
# Record which offsets already have a polybar instance
declare -A seen_offsets

# Function to check if a bar already exists for this monitor
bar_exists() {
  local monitor=$1
  local already=$(pgrep -a -u $UID polybar | grep -F "MONITOR=$monitor " || true)
  [[ -n "$already" ]]
}

# Terminate already running bar instances
polybar-msg cmd quit 2>/dev/null || killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 0.2; done

# Automatically detect and launch on all connected monitors
if type "xrandr" >/dev/null; then
  # Detect primary monitor, default to first connected monitor if not set
  primary_monitor=$(xrandr --query | grep " primary" | cut -d" " -f1)
  if [[ -z "$primary_monitor" ]]; then
    primary_monitor=$(xrandr --query | grep " connected" | cut -d" " -f1 | head -n 1)
  fi

  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    # Get the geometry (e.g., 1920x1080+0+0) for this specific monitor
    geometry=$(xrandr --query | grep "^$m" | grep -o -E "[0-9]+x[0-9]+\+[0-9]+\+[0-9]+")

    # Skip connected monitors that are turned off / have no active geometry
    [[ -z "$geometry" ]] && continue

    # Extract just the offset coordinates (e.g., +0+0)
    offset=$(echo "$geometry" | grep -o -E "\+[0-9]+\+[0-9]+")

    if [[ -n "$offset" ]]; then
      # Skip if we've already spawned a bar for this offset (mirrored or duplicate detection)
      if [[ -n "${seen_offsets[$offset]}" ]]; then
        echo "Monitor $m shares offset $offset with ${seen_offsets[$offset]} (Duplicate). Skipping Polybar."
        continue
      fi
      # Mark this coordinate space as populated
      seen_offsets[$offset]=$m
    fi

    # Skip if a bar already exists for  this monitor (hotplug race condition guard)
    if bar_exists "$m"; then
      echo "Bar already running on $m. Skipping."
      continue
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
