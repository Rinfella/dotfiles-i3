---
description: Read and analyze system logs
---

Read and analyze system logs using journalctl.

## Steps:
1. Ask for log source and timeframe.
2. Execute appropriate journalctl command.
3. Analyze entries.
4. Provide summary of issues.

## Common Commands

```bash
# All logs
journalctl -xe

# Specific service
journalctl -u nginx -n 50
journalctl -u nginx --since "1 hour ago"

# By time
journalctl --since "2024-01-01"
journalctl --since "1 hour ago"
journalctl --since "yesterday"

# Priority (0=emerg to 7=debug)
journalctl -p err

# Boot
journalctl -b
journalctl -b -1  # Previous boot

# Disk usage
journalctl --disk-usage

# Follow logs
journalctl -f

# Errors only
journalctl -p err -b
```

## Constraints:
- Use `-n` to limit lines.
- Use `--since`/`--until` for time ranges.