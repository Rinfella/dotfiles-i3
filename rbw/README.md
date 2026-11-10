# rbw

Unofficial Bitwarden / Vaultwarden CLI client.

## Prerequisites
- `rbw` (CLI client)
- `rofi-rbw` (Rofi GUI picker)
- `pinentry` (for secure master password unlocking)

## Configuration
Config stored at `~/.config/rbw/config.json`.

## Usage & Commands

```bash
# Unlock vault for the session
rbw unlock

# Sync vault items with server
rbw sync

# Search credentials in terminal
rbw get <entry_name>

# List all vault items
rbw list
```

## GUI Integration
In i3wm: press **`Mod+p`** to open `rofi-rbw`. Type to search logins and press Enter to copy credentials to clipboard without opening a browser.
