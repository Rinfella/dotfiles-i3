---
description: Checks system resource usage
---

Check system resource usage (CPU, memory, disk, processes).

## Steps:
1. Ask what to check (or show all).
2. Execute appropriate command.

## Quick Commands

```bash
# CPU & Memory
htop          # Interactive
top           # Basic
free -h       # Memory
uptime        # Load average

# Disk usage
df -h         # Disk space
du -sh */     # Directory sizes
ncdu         # Interactive disk analyzer

# Process list
ps aux --sort=-%cpu | head -10  # Top CPU
ps aux --sort=-%mem | head -10  # Top Memory

# I/O
iostat -x 1 5
iotop        # Requires sudo

# Network
ss -tuln    # Listening ports
netstat -tuln  # (deprecated)
```

## Quick Reference

| Command | Purpose |
|---------|---------|
| `htop` | Interactive system monitor |
| `free -h` | Memory usage |
| `df -h` | Disk space |
| `du -sh *` | Directory sizes |
| `ps aux --sort=-%cpu` | Top CPU processes |
| `ss -tuln` | Open ports |