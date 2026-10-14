# easyeffects

Audio effects, equalization, and processing for PipeWire.

## Prerequisites
- `easyeffects`
- `pipewire`, `wireplumber`

## Storage & Profiles
- **Profiles / Presets:** `~/.local/share/easyeffects` (symlinked from `doti3/easyeffects`)
- **Config & State:** `~/.config/easyeffects`

### Available Output Presets (`easyeffects/output/`):
- **`Crinacle32B.json`**: Crinacle target 32-band curve for balanced monitoring.
- **`Flat Default.json`**: Neutral flat reference profile without EQ coloration.
- **`Zero2-10B.json`**: 7Hz x Crinacle Zero:2 10-band hardware target compensation.
- **`Waner SG2.json`**: Tangzu Wan'er S.G 2 IEM target profile.

## Service & Daemon Management (Zsh Aliases)
EasyEffects runs primarily via systemd user unit `easyeffects.service` (`easyeffects --gapplication-service`).

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
