# polybar

Status bar configuration for i3wm.

## Prerequisites
- `polybar`
- JetBrains Mono Nerd Font, Font Awesome / Material icons
- `i3-wm`, `wireplumber` (audio), `brightnessctl`, `networkmanager`

## Modules & Interactive Clicks
- **Workspaces:** i3 workspace status with icons
- **Window Title:** Active focused window
- **CPU / Memory / Temp:** Hardware resource monitors
- **Volume / Audio:** Left-click opens `pavucontrol`, scroll adjusts volume, middle-click toggles mute
- **Brightness:** Scroll to increase/decrease display brightness
- **Network / WiFi:** Left-click opens `nmtui` in Kitty terminal for instant WiFi selection
- **Bluetooth:** Left-click opens `bluetui` in Kitty
- **Battery:** Charge state, percentage, and dynamic ramp icons
- **Date / Clock:** Time and calendar pop-over

## Management
```bash
# Relaunch / reload polybar
~/.config/polybar/launch.sh

# Check polybar logs
cat /tmp/polybar.log
```
