# doti3

Dotfiles for **Arch Linux + i3wm**. Managed with [mise](https://mise.jdx.dev).

---

## ⚡ Fresh Machine (One-liner)

```bash
curl -fsSL https://raw.githubusercontent.com/Rinfella/dotfiles-i3/master/bootstrap.sh | bash
```

Installs `git` → `yay` → `mise` → clones repo → runs full setup automatically.

## ⚡ Day-to-day Commands

```bash
mise dot apply               # apply / re-apply all dotfile symlinks
mise dot status              # check symlink status
mise dot diff                # preview pending changes
mise run packages            # install / sync all packages via yay
mise run verify              # smoke-test i3, rofi, nvim configs
mise run cron                # reinstall crontab entries
mise run udev                # install / refresh monitor hotplug udev rule
mise run systemd             # reload and enable user systemd services
mise run setup               # full re-run: packages → dotfiles → env → cron → udev → systemd → verify
```

---

## 📚 Component Cheatsheets

Each configuration directory has its own dedicated `README.md` with cheatsheets, keybinds, and setup notes:

| Component | Directory | Description |
|-----------|-----------|-------------|
| **i3wm** | [`i3/`](./i3/README.md) | Window manager, tiling, workspace & monitor hotplug keys |
| **Neovim** | [`nvim/`](./nvim/README.md) | Lazy.nvim, LSP, Obsidian note-taking, shortcuts |
| **Tmux** | [`tmux/`](./tmux/README.md) | Multiplexer, session persistence, Vim navigation |
| **Yazi** | [`yazi/`](./yazi/README.md) | Rust TUI file manager with shell `y` wrapper |
| **Zsh** | [`zsh/`](./zsh/README.md) | Modular shell, aliases, `navi` widget (`Ctrl+G`), `atuin` |
| **Picom** | [`picom/`](./picom/README.md) | Compositor, dual-kawase blur, rounded corners, fading |
| **Polybar** | [`polybar/`](./polybar/README.md) | Status bar modules, audio/brightness scrolls |
| **Dunst** | [`dunst/`](./dunst/README.md) | Notification daemon shortcuts & history |
| **Kitty** | [`kitty/`](./kitty/README.md) | Primary GPU terminal keybinds |
| **Alacritty** | [`alacritty/`](./alacritty/README.md) | Secondary terminal config |

---

## Architecture & Bootstrapping

For full technical specifications on the `mise`-driven bootstrap architecture, see [`ai/superpowers/plans/2026-09-29-bootstrap-mise-dotfiles.md`](./ai/superpowers/plans/2026-09-29-bootstrap-mise-dotfiles.md).
