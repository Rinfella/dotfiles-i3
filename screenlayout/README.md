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
| `dp-only.sh` | Turn off laptop screen, use DisplayPort Type-C only (portrait) | — |
| `dp-extended-right.sh` | Laptop + DisplayPort Type-C portrait (right) | — |
| `dual-external.sh` | HDMI + DP Type-C portrait (laptop closed) | — |
| `dual-landscape.sh` | HDMI + DP Type-C landscape (laptop closed) | — |
| `triple-extended.sh` | Laptop + HDMI + DP Type-C portrait | — |
| `triple-landscape.sh` | Laptop + HDMI + DP Type-C landscape | — |

Interactive switcher in i3: **`Mod+Shift+p`** (opens Rofi screen-layout picker).

## Type-C DisplayPort Rotation Fix

**Issue:** `xorg-server 21.1.25` introduced a regression where rotated DisplayPort CRTC state persists in the kernel and causes AMD driver crashes on session start when using Type-C alt-mode monitors.

**Symptoms:**
- Plugging Type-C DP monitor logs you out immediately
- Cannot log back in while Type-C DP is connected
- Xorg crash with `drmmode_do_crtc_dpms cannot get last vblank counter`

**Solution Applied (Oct 2026):**
1. **Downgraded xorg-server** to `21.1.24-1` and added to `IgnorePkg` in `/etc/pacman.conf`
2. **Two-pass xrandr rotation** in portrait layout scripts:
   - Pass 1: Bring up all outputs in landscape to establish canvas
   - Pass 2: Apply rotation after 0.5s sleep (lets Type-C alt-mode plane initialize)
3. **Connectivity guards** in all DP-1 scripts — graceful failure with notifications instead of crashes

**Portrait layout scripts affected:**
- `triple-extended.sh`, `dual-external.sh`, `dp-extended-right.sh`, `dp-only.sh`

**To upgrade xorg-server later** (when 21.1.26+ fixes the regression):
```bash
sudo sed -i 's/^IgnorePkg = xorg-server xorg-server-common/#IgnorePkg =/' /etc/pacman.conf
sudo pacman -Syu
# Test Type-C DP rotation — if it crashes again, re-apply downgrade
```

## Quick Rotation Toggle

Toggle DisplayPort-1 between portrait (left) and landscape (normal) rotation:

**Keybind:** `Mod+Shift+o`

Uses `~/.config/i3/scripts/toggle-dp-rotation` to cycle rotation without going through the Rofi menu.
