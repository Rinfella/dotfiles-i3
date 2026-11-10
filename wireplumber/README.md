# wireplumber

Modular PipeWire session manager configuration.

## Prerequisites
- `pipewire`, `wireplumber`

## Custom Configurations (`wireplumber.conf.d/`)
- `51-device-rename.conf` — Custom audio node naming and priority rules for external DACs/monitors/headphones.

## Service Commands
```bash
systemctl --user restart wireplumber      # restart session manager
wpctl status                              # view audio nodes and volume levels
wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ # adjust default output volume
```
