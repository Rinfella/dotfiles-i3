# Mise Migration Guide

**Last Updated:** 2026-11-06  
**Target Version:** mise v2024.10.0+  

---

## What is Mise?

[mise](https://mise.jdx.dev) is a modern toolchain manager that replaces:

| Legacy Tool | Replaced By |
|-------------|-------------|
| `nvm` | `mise` (node, deno, php via vfox) |
| `asdf` | `mise` (all runtimes) |
| Manual symlink scripts | `mise dot` (dotfile management) |
| `homebrew` / `apt` for CLI tools | `mise` (bat, delta, eza, etc.) |

---

## Core Commands

### Toolchain Management

```bash
# List installed runtimes
mise list

# Install a new runtime
mise install node@24
mise install php@8.5

# Set global version
mise global node@24 php@8.5

# Pin versions per project
mise local node@24 php@8.5

# Upgrade all tools
mise upgrade
```

### Dotfile Management

```bash
# Apply all symlinks (idempotent)
mise dot apply

# Preview what will change
mise dot diff

# Check symlink status
mise dot status

# Force overwrite existing files
mise dot apply --force

# Show all managed dotfiles
mise dot ls
```

### Task Runner

```bash
# Run a named task
mise run packages     # install all system packages
mise run verify       # smoke-test configs
mise run cron         # reinstall crontab

# List all available tasks
mise tasks
```

---

## Project-Specific Setup

### Fresh Machine (One-liner)

```bash
curl -fsSL https://raw.githubusercontent.com/Rinfella/dotfiles-i3/master/bootstrap.sh | bash
```

This:
1. Installs `git` and `yay`
2. Bootstraps `mise`
3. Clones `doti3` repo
4. Runs `mise run setup`

### Day-to-Day Workflows

```bash
# Sync packages and dotfiles
mise run setup

# Update all tools
mise upgrade --bump

# Verify all configs work
mise run verify

# Push dotfile changes
git push origin feat/your-branch
```

---

## Configuration Files

### `mise/config.toml`

Located at `~/.config/doti3/mise/config.toml` (symlinked to `~/.config/mise/config.toml`).

```toml
[tools]
node   = "24"
php    = "8.5"
go     = "latest"

[dotfiles]
"~/.zshenv" = { source = "~/.config/doti3/zsh/.zshenv", mode = "symlink" }
```

### `mise/tasks.toml`

Located at `~/.config/doti3/mise/tasks.toml`.

```toml
[tasks.setup]
description = "Full fresh-machine setup"
run = [
  "mise run packages",
  "mise dot apply",
  "mise run cron",
  "mise run systemd",
  "mise run verify"
]
```

---

## Troubleshooting

### "mise: command not found"

```bash
# Reinstall mise
curl https://mise.run | sh

# Or use brew if you prefer
brew install mise
```

### Symlinks not created

```bash
# Check dotfile status
mise dot status

# Preview changes
mise dot diff

# Apply with verbose output
mise dot apply -v
```

### Runtime not found

```bash
# Ensure shims are in PATH
echo 'export PATH="$HOME/.local/share/mise/shims:$PATH"' >> ~/.zshenv

# Reload shell
exec zsh

# Verify
which node
```

---

## Migration Checklist

- [ ] Remove `nvm` install: `rm -rf ~/.nvm ~/.npm _npx`
- [ ] Removee `asdf` if installed
- [ ] Update any scripts that call `nvm use`
- [ ] Replace `deploy.sh` with `mise dot apply`
- [ ] Add `mise dot status` to CI checks
- [ ] Update documentation references

---

## Related Docs

- [`README.md`](../README.md) — main project docs
- [`deploy-deprecation.md`](./deploy-deprecation.md) — `deploy.sh` deprecation notice
- [`zsh/README.md`](../../zsh/README.md) — Zsh modular configuration guide
