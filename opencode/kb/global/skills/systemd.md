---
description: Manages system services with systemd
---

Manage systemd services.

## Steps:
1. Ask for the service name and action.
2. Execute the appropriate command.

## Common Commands

```bash
# Check status
systemctl status <service>

# Start/Stop/Restart
sudo systemctl start <service>
sudo systemctl stop <service>
sudo systemctl restart <service>

# Enable/Disable at boot
sudo systemctl enable <service>
sudo systemctl disable <service>

# List all services
systemctl list-units --type=service

# View logs
journalctl -u <service> -n 50
journalctl -u <service> --since "1 hour ago"
```

## Constraints:
- Use sudo for system-wide changes.
- Check status before making changes.