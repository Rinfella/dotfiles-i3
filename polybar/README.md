# polybar

Status bar configuration for i3wm.

## Prerequisites
- `polybar`
- JetBrains Mono Nerd Font, Font Awesome / Material icons
- `i3-wm`, `wireplumber` (audio), `brightnessctl`, `networkmanager`

## Modules & Behavior
- **Workspaces:** i3 workspace status with icons
- **Window Title:** Active focused window
- **CPU / Memory / Temp:** Hardware resource monitors
- **Volume / Audio:** Interactive click to mute, scroll to adjust volume
- **Brightness:** Scroll to increase/decrease display brightness
- **Network / WiFi:** Active connection status
- **Battery:** Charge state + percentage
- **Date / Clock:** Time and calendar pop-over

## Management
```bash
# Relaunch / reload polybar
~/.config/polybar/launch.sh

# Check polybar logs
cat /tmp/polybar.log
```
