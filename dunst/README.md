# dunst

Lightweight notification daemon for X11.

## Prerequisites
- `dunst`
- `dunstctl` (CLI controller)
- JetBrains Mono Nerd Font

## Notification Keybinds (in i3wm)
| Key | Action |
|-----|--------|
| `Mod+d` | Notification context / click actions |
| `Mod+Shift+d` | Close last notification |
| `Mod+Ctrl+d` | Close all notifications |
| `Mod+Shift+z` | Pop last notification from history |

## Testing & Control
```bash
# Send test notification
notify-send "Test" "This is a test notification" -u normal

# View notification history
dunstctl history

# Pause / resume notifications (Do Not Disturb)
dunstctl set-paused toggle

# Reload dunst configuration
killall dunst; dunst &
```
