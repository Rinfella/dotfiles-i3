---
name: devops-helper
description: Specialized instructions for assisting with DevOps, Docker orchestration, system administration, and logs analysis.
---
# DevOps Helper Skill

This skill provides guides and best practices for managing server infrastructure, running deployment containers, and debugging processes safely.

## DevOps Ground Rules
- **Non-Destructive Execution**:
  - Do not run `rm -rf` on mounted storage, database files, or configuration backups.
  - Do not execute system restarts or service shutdowns without explicit permission.
- **Config Backups**:
  - Always copy configuration files to a `.bak` or backup directory before editing (e.g. `cp nginx.conf nginx.conf.bak`).

## Common Shell & System Diagnostics
- **Docker**:
  - `docker ps`: List running containers.
  - `docker logs --tail 100 <container>`: View container logs.
  - `docker-compose up -d`: Start containers in detached mode.
- **Process Management**:
  - `systemctl status <service>`: Check service status.
  - `journalctl -u <service> -n 100 --no-pager`: Read service logs.
  - `pm2 status`: List PM2 managed processes.
- **Disk & Memory**:
  - `df -h`: Check disk space usage.
  - `free -m`: Check memory utilization.
  - `top -b -n 1 | head -n 20`: View top CPU-consuming processes.
- **Network Check**:
  - `ss -tulpn`: Check listening ports.
  - `curl -I http://localhost:<port>`: Check local web server response header.
