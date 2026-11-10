# rofi

Application launcher, window switcher, powermenu, and clipboard/password picker.

## Prerequisites
- `rofi`
- `clipmenu` (clipboard integration)
- `rofi-rbw` (Bitwarden integration)
- `i3lock` (lockscreen script)

## Keybinds (in i3wm)

| Key | Modal | Command |
|---|---|---|
| `Mod+space` | Application Launcher | `rofi -modi drun -show drun -config rofidmenu.rasi` |
| `Mod+Shift+t` | Window Switcher | `rofi -show window -config rofidmenu.rasi` |
| `Mod+c` | Clipboard Manager | `clipmenu -theme clipmenu.rasi` |
| `Mod+p` | Bitwarden / RBW | `rofi-rbw -theme rbw.rasi` |
| `Mod+Shift+p` | Screen Layout Switcher | `~/.config/i3/scripts/screen-layout` |
| `Mod+Shift+e` | System Powermenu | `~/.config/i3/scripts/powermenu` |

## Themes & Configurations
- `rofidmenu.rasi` — Clean grid application launcher
- `powermenu.rasi` — Quick exit, sleep, reboot, shutdown modal
- `clipmenu.rasi` — Sleek clipboard history popup
- `rbw.rasi` — Vaultwarden / Bitwarden credentials selector
