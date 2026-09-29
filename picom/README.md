# picom

X11 compositor configuration for transparency, blur, shadows, and fading.

## Prerequisites
- `picom` (GLX backend, OpenGL support)
- Mesa / GPU drivers

## Features Configured
- **Backend:** `glx` with `vsync = true`
- **Blur:** `dual_kawase` (strength 5)
- **Corners:** `corner-radius = 8` (subtle rounded windows)
- **Fading:** Smooth 150ms open/close fade (`fade-in-step = 0.03`, `fade-delta = 5`)
- **Shadows:** Enabled with smart exclusions for Polybar, i3bar, notifications
- **Opacity:**
  - Active windows: `100%`
  - Inactive windows: `85%` (via rule)
  - Dock / Polybar / Rofi: `100%`

## Controls & Daemon
```bash
# Restart picom after editing config
pkill picom && picom --daemon

# Check if picom is running
pgrep -x picom

# Run in foreground for debugging
picom --config ~/.config/picom/picom.conf
```
