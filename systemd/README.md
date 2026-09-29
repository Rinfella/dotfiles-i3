# systemd

User-level systemd service units enabled by `mise run systemd`.

## Prerequisites
- `systemd` (user session)

## Units (`systemd/user/`)
- `easyeffects.service` — Runs EasyEffects audio daemon in the background
- `omniroute.service` — Local AI gateway & proxy server

## Management
```bash
# Sync and enable all user units
mise run systemd

# Check status of user services
systemctl --user status easyeffects
systemctl --user status omniroute

# View live service logs
journalctl --user -u omniroute -f
journalctl --user -u easyeffects -f
```
