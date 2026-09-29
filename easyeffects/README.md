# easyeffects

Audio effects, equalization, and processing for PipeWire.

## Prerequisites
- `easyeffects`
- `pipewire`, `wireplumber`

## Storage & Profiles
- **Profiles / Presets:** `~/.local/share/easyeffects` (symlinked from `doti3/easyeffects`)
- **Config & State:** `~/.config/easyeffects`

## Service & Daemon Management (Zsh Aliases)

| Alias | Command | Purpose |
|---|---|---|
| `ees` | `systemctl --user status easyeffects` | Check daemon status |
| `eer` | `systemctl --user restart easyeffects` | Restart daemon & reload profiles |
| `eequit` | `systemctl --user stop easyeffects` | Stop daemon |
| `eelogs` | `journalctl --user -u easyeffects -f` | View live processing logs |

## Launching GUI
```bash
easyeffects      # opens the full GUI window to edit curves and plugins
```
