# i3wm

i3 window manager configuration for Arch Linux.

## Prerequisites
- `i3-wm`, `picom`, `polybar`, `rofi`, `dunst`, `kitty`
- `maim`, `xdotool`, `feh`, `brightnessctl`, `playerctl`, `blueman`
- `clipmenu`, `rbw`, `rofi-rbw`
- JetBrains Mono Nerd Font

## Keybinds

> Mod = `Super` (Windows key)

### Applications & System
| Key | Action |
|-----|--------|
| `Mod+Return` | Terminal (`kitty`) |
| `Mod+Shift+Return` | Dropdown terminal (scratchpad) |
| `Mod+space` | App launcher (`rofi`) |
| `Mod+Shift+t` | Window switcher (`rofi`) |
| `Mod+e` | File manager (`thunar`) |
| `Mod+b` | Bluetooth manager (`bluetui`) |
| `Mod+Shift+b` | Toggle Bluetooth hardware |
| `Mod+c` | Clipboard history (`clipmenu` via rofi) |
| `Mod+p` | Bitwarden / Vaultwarden (`rofi-rbw`) |
| `Mod+Shift+e` | Powermenu (logout / reboot / shutdown) |
| `Mod+Escape` | Lock screen |
| `Mod+F1` | Keybinding cheat sheet |
| `Mod+q` | Close focused window |
| `Mod+Shift+c` | Reload i3 config in-place |
| `Mod+Shift+r` | Restart i3 |

### Navigation & Windows
| Key | Action |
|-----|--------|
| `Mod+h/j/k/l` | Focus window left / down / up / right |
| `Mod+Shift+h/j/k/l` | Move window left / down / up / right |
| `Mod+y` | Split horizontally |
| `Mod+v` | Split vertically |
| `Mod+f` | Toggle fullscreen |
| `Mod+s` | Stacking layout |
| `Mod+g` | Tabbed layout |
| `Mod+t` | Toggle split layout |
| `Mod+Shift+space` | Toggle floating |
| `Mod+a` | Focus parent container |
| `Mod+Shift+minus` | Send to scratchpad |
| `Mod+minus` | Toggle scratchpad |
| `Mod+r` | Enter resize mode (arrows/hjkl to resize, Esc to exit) |

### Workspaces
| Key | Action |
|-----|--------|
| `Mod+1..0` | Switch to workspace 1..10 |
| `Mod+Shift+1..0` | Move window to workspace 1..10 and follow |
| `Mod+Tab` | Next workspace |
| `Mod+Shift+Tab` | Previous workspace |

### Multi-Monitor / Displays
| Key | Action |
|-----|--------|
| `Mod+Shift+a` | Auto-detect displays (hotplug script) |
| `Mod+Shift+s` | Single monitor only (laptop) |
| `Mod+Shift+m` | Extended right |
| `Mod+Shift+u` | Extended up |
| `Mod+m` | Mirror displays |
| `Mod+Shift+p` | Interactive layout switcher (`rofi`) |

### Media & Hardware
| Key | Action |
|-----|--------|
| `XF86AudioRaiseVolume` | Volume +5% |
| `XF86AudioLowerVolume` | Volume -5% |
| `XF86AudioMute` | Toggle audio mute |
| `XF86AudioMicMute` | Toggle microphone mute |
| `XF86MonBrightnessUp` | Brightness +5% |
| `XF86MonBrightnessDown` | Brightness -5% |
| `XF86AudioPlay/Pause` | Play / pause media |
| `XF86AudioNext/Prev` | Next / previous track |
| `Mod+x` | Screenshot (full screen → clipboard & disk) |
| `Mod+Ctrl+x` | Screenshot (selection) |

### Notifications (Dunst)
| Key | Action |
|-----|--------|
| `Mod+d` | Context / action on notification |
| `Mod+Shift+d` | Dismiss notification |
| `Mod+Ctrl+d` | Dismiss all notifications |
| `Mod+Shift+z` | Notification history pop |

## Scripts (`i3/scripts/`)
- `autodetect-display` — triggered automatically via udev on HDMI/DP plug
- `lock-screen` — blurred screenshot lock via `i3lock`
- `powermenu` — rofi-based logout/reboot/poweroff
- `screen-layout` — rofi monitor selector
- `volume_brightness` — OSD popups on volume/brightness change
- `keyhint-2` — quick-reference GUI for shortcuts
