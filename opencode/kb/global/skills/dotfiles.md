---
description: Manages the doti3 dotfile configuration repo
---

This repo manages dotfiles via symlinks from `~/.config/doti3/`.

## Deploy

```bash
cd ~/.config/doti3
./deploy.sh --dry-run    # Preview
./deploy.sh              # Deploy
```

## Config Structure

| Path | Target | Description |
|------|--------|-------------|
| `zsh/` | `~/.config/zsh/` | Zsh modular config |
| `i3/` | `~/.config/i3/` | i3wm + scripts |
| `nvim/` | `~/.config/nvim/` | Neovim config |
| `opencode/` | `~/.config/opencode/` | Opencode AI config |
| `kitty/`, `alacritty/` | `~/.config/` | Terminal emulators |
| `polybar/`, `picom/`, `rofi/`, `dunst/` | `~/.config/` | Desktop env |
| `tmux/` | `~/.config/tmux/` | Terminal multiplexer |
| `yazi/` | `~/.config/yazi/` | File manager |
| `screenlayout/` | `~/.screenlayout` | Display layouts |
| `starship.toml` | `~/.config/starship.toml` | Prompt |
| `zsh/.zshenv` | `~/.zshenv` | Env vars (XDG config) |
| `curlrc`, `wgetrc`, `inputrc`, `gitconfig`, `npmrc`, `yarnrc` | `~/.config/` | Tool configs |

## Key Features
- XDG-compliant directory structure (CONFIG_HOME, CACHE_HOME, DATA_HOME, STATE_HOME)
- Automatic display detection via HDMI + lid state
- Modular zsh config via conf.d/
- Desktop env: i3 + polybar + picom + rofi + dunst
- Backup on deploy (timestamped backups)
