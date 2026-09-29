# screenlayout

Xrandr monitor configurations for multi-display and laptop setups.

## Prerequisites
- `xorg-xrandr`
- `autorandr` or custom i3 screen scripts

## Scripts Available
| Script | Layout Mode | i3 Keybind |
|---|---|---|
| `single.sh` | Laptop internal display only (eDP-1) | `Mod+Shift+s` |
| `extended-right.sh` | External monitor placed to the right | `Mod+Shift+m` |
| `extended-up.sh` | External monitor placed above laptop | `Mod+Shift+u` |
| `extended-left.sh` | External monitor placed to the left | — |
| `mirror.sh` | Duplicate laptop display onto external display | `Mod+m` |
| `hdmi-only.sh` | Turn off laptop screen, use HDMI only | — |
| `dp-only.sh` | Turn off laptop screen, use DisplayPort only | — |
| `dual-landscape.sh` | Dual external monitor workstation layout | — |

Interactive switcher in i3: **`Mod+Shift+p`** (opens Rofi screen-layout picker).
