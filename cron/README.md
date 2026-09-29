# cron

User crontab definitions synced automatically by `mise run cron`.

## Files
- `duckdns` — Periodically updates DuckDNS dynamic IP via curl every 5 minutes.

## Management
```bash
# Sync crontabs from this directory
mise run cron

# Inspect active crontabs
crontab -l
```
