# screenlayout

Xrandr monitor configurations for multi-display and laptop setups.

## Prerequisites
- `xorg-xrandr`
- `autorandr` or custom i3 screen scripts

## Scripts Available
| Script | Layout Mode | i3 Keybind |
|---|---|---|
| `single.sh` | Laptop internal display only (eDP-1) | `Mod+Shift+s` |
| `extended-right.sh` | Ext Right (laptop + HDMI) | `Mod+Shift+m` |
| `extended-up.sh` | Ext Up (laptop + HDMI) | `Mod+Shift+u` |
| `extended-left.sh` | Ext Left (laptop + HDMI) | — |
| `mirror.sh` | Mirror all displays | `Mod+m` |
| `hdmi-only.sh` | HDMI only (laptop closed) | — |
| `dp-only.sh` | DP only (landscape, laptop closed) | — |
| `dp-extended-right.sh` | Laptop + DP landscape (right) | — |
| `dual-external.sh` | Dual Ext landscape (laptop closed, HDMI + DP) | — |
| `dual-external-portrait.sh` | Dual Ext portrait (laptop closed, HDMI + DP) | — |
| `triple-extended.sh` | Triple Ext DP portrait (laptop + HDMI + DP) | — |
| `triple-landscape.sh` | Triple Ext landscape (laptop + HDMI + DP) | — |

Interactive switcher in i3: **`Mod+Shift+p`** (opens Rofi screen-layout picker).

## Type-C DisplayPort Rotation Fix

**Issue:** `xorg-server 21.1.25` introduced a regression where rotated DisplayPort CRTC state persists in the kernel and causes AMD driver crashes on session start when using Type-C alt-mode monitors.

**Symptoms:**
- Plugging Type-C DP monitor logs you out immediately
- Cannot log back in while Type-C DP is connected
- Xorg crash with `drmode_do_crtc_dpms cannot get last vblank counter`

**Solution Applied (Nov 2026):**
1. **Removed xorg-server** from `IgnorePkg` in `/etc/pacman.conf`
2. **Added dual-external-portrait.sh** as a dedicated portrait layout option

**All DP layouts default to landscape (`--rotate normal`) for simplicity.**
Use portrait mode only where you need it (triple-extended, dual-external-portrait).

**To enable portrait mode:**
```bash
xrandr --output DisplayPort-1 --rotate left
```

## Quick Rotation Toggle

Toggle DisplayPort-1 between portrait (left) and landscape (normal) rotation:

**Keybind:** `Mod+Shift+o`

Uses `~/.config/i3/scripts/toggle-dp-rotation` to cycle rotation without going through the Rofi menu.
