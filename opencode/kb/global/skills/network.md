---
description: Network diagnostics and port management
---

Network diagnostics and port management.

## Steps:
1. Ask what to check.
2. Execute appropriate command.

## Common Commands

```bash
# Check connections
ss -tuln          # Listening ports
ss -tunap         # All connections with PIDs
netstat -tuln      # (deprecated)

# Test connectivity
ping -c 4 host
curl -I https://url
wget -q --spider url

# DNS lookup
dig domain
nslookup domain
host domain

# Firewall (ufw)
sudo ufw status
sudo ufw allow 22/tcp
sudo ufw deny 80/tcp

# Speed test
speedtest-cli

# Local network
ip addr
ip route
arp -a
```

## Quick Port Reference

| Port | Service |
|------|---------|
| 22 | SSH |
| 80 | HTTP |
| 443 | HTTPS |
| 3306 | MySQL |
| 5432 | PostgreSQL |
| 6379 | Redis |
| 80xx | Dev servers |