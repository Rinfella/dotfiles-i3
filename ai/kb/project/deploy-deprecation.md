# Deploy Script Deprecation Notice

**Status:** 📝 **DEPRECATED**  
**Superseded by:** `mise dot apply`  
**Date:** 2026-11-06  

---

## What Changed?

The `deploy.sh` script has been replaced by the `mise dot` subcommand introduced in [mise v2024.10.0+](https://github.com/jdx/mise/releases).

| Task | Old (`deploy.sh`) | New (`mise dot`) |
|------|-------------------|------------------|
| Apply symlinks | `./deploy.sh` | `mise dot apply` |
| Check status | — | `mise dot status` |
| Preview changes | — | `mise dot diff` |
| Force overwrite | `./deploy.sh --force` | `mise dot apply --force` |

---

## Why Deprecate `deploy.sh`?

- **Single source of truth:** `mise` already knows about your dotfiles via `[dotfiles]` in `config.toml`
- **No backup logic needed:** `mise dot apply` creates automatic backups with versioned suffixes (`.bak.YYYYMMDDHHMMSS`)
- **Idempotent:** `mise dot apply` is naturally idempotent; no need for `--dry-run` checks
- **Better diffing:** `mise dot diff` shows exactly what will change before applying

---

## Migration Steps

1. **Verify `mise` version:**
   ```bash
   mise --version  # requires v2024.10.0+
   ```

2. **Run `mise dot` equivalents:**
   ```bash
   mise dot status   # see what symlinks are managed
   mise dot diff     # preview changes
   mise dot apply    # apply all dotfile symlinks
   ```

3. **Update any automation:**
   Replace:
   ```bash
   ~/.config/doti3/deploy.sh --dry-run
   ```
   With:
   ```bash
   mise dot diff
   ```

---

## Whhat Happens to `deploy.sh`?

- ✅ **Kept for reference** — the file remains in the repo
- ⚠️ **No active maintenance** — bugs or feature requests will be declined
- 🔒 **Read-only** — expect only documentation updates to its header

---

## Related Files

- [`README.md`](./README.md) — updated to reference `mise dot` as primary
- [`ai/kb/project/mise-migration.md`](./ai/kb/project/mise-migration.md) — full migration guide
