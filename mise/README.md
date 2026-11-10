# mise

Universal tool runtime version manager and dotfiles manager.

- **Docs:** [mise.jdx.dev](https://mise.jdx.dev)
- **Config:** `config.toml` (symlinked to `~/.config/mise/config.toml`)

## What Mise Manages in `doti3`

1. **Runtimes & Compilers:**
   - PHP (`8.5`), Node.js (`24`), Gradle (`9.4.1`), Go (`latest`), Deno (`latest`)
2. **CLI Tools (replaces pacman):**
   - `atuin`, `bat`, `delta`, `direnv`, `duf`, `eza`, `fastfetch`, `glow`, `lazydocker`, `lazygit`, `navi`, `neovim`, `starship`, `yazi`, `yt-dlp`, `zoxide`
3. **Dotfiles Matrix:**
   - Automatically maintains 47+ symlinks targeting `~/.config/` and `~/` via `mise dot apply`
4. **Task Runner:**
   - `mise run setup` — Full bootstrap pipeline
   - `mise run packages` — Synchronize pacman/AUR packages
   - `mise run verify` — Smoke-test i3, nvim, rofi, and dotfiles
   - `mise run doctor` — System health diagnostic (nvim checkhealth, i3 syntax, symlink matrix)
   - `mise run clean` — Clean orphaned packages (`pacman -Qtdq`), trim pacman cache, and prune mise builds
   - `mise run cron` — Sync crontabs
   - `mise run udev` — Write monitor hotplug rule
   - `mise run systemd` — Enable and reload user systemd units

## Quick Cheatsheet

| Action | Command | Alias |
|---|---|---|
| Apply dotfiles symlinks | `mise dot apply` | `mdota` |
| View dotfile status | `mise dot status` | `mdots` |
| Preview dotfile changes | `mise dot diff` | `mdotd` |
| Install configured tools | `mise install` | `mi` |
| Upgrade all tools | `mise upgrade` | `mup` |
| List installed tools | `mise ls` | `mls` |
| Set local/project version | `mise use <tool>@<version>` | `mu <tool>@<version>` |
| Execute task | `mise run <task>` | `mr <task>` |
