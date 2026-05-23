---
description: Manages the doti3 dotfile configuration repo
---

# doti3 Dotfiles

Centralized dotfile management via symlinks from `~/.config/doti3/`.

## Deploy

```bash
cd ~/.config/doti3
./deploy.sh --dry-run        # Preview (safe)
./deploy.sh                   # Deploy symlinks
./deploy.sh --install-deps    # Deploy + install packages (sudo)
```

## Config Structure

### Directory symlinks (`~/.config/<tool>` → `doti3/<tool>`)

| Tool | Type | Description |
|------|------|-------------|
| `alacritty/` | Terminal | GPU-accelerated terminal |
| `atuin/` | Shell | Shell history with sync |
| `autostart/` | Desktop | Autostart .desktop files |
| `bat/` | Shell | Better cat (Catppuccin Mocha theme) |
| `dunst/` | Desktop | Notification daemon |
| `easyeffects/` | Audio | EQ presets + live config (db/, output/, autoload/) |
| `fastfetch/` | System | System info fetch |
| `fontconfig/` | System | Font rendering (JetBrainsMono Nerd Font) |
| `i3/` | WM | i3wm config + scripts (polybar, powermenu, etc.) |
| `kitty/` | Terminal | Terminal emulator (JetBrainsMono, Catppuccin) |
| `nvim/` | Editor | Neovim (LazyVim-style) |
| `opencode/` | AI | Opencode AI coding assistant |
| `picom/` | Desktop | Compositor (shadows, blur, transparency) |
| `polybar/` | Desktop | Status bar |
| `rofi/` | Desktop | App launcher + window switcher + clipboard + powermenu |
| `systemd/` | System | User systemd services (tmux) |
| `tmux/` | Terminal | Terminal multiplexer (TPM + Catppuccin + resurrect) |
| `vim/` | Editor | Vim config (Vi mode, undodir) |
| `X11/` | System | Xresources (Qogir-dark cursor) |
| `yazi/` | File Mgr | Fast terminal file manager |
| `zsh/` | Shell | Modular conf.d/ config |

### File symlinks (single files)

| doti3 | Target | Description |
|-------|--------|-------------|
| `mise.toml` | `~/.config/mise/config.toml` | Runtime version manager |
| `starship.toml` | `~/.config/starship.toml` | Prompt |
| `zsh/.zshenv` | `~/.zshenv` | XDG env vars |
| `screenlayout/` | `~/.screenlayout` | Display layouts |
| `curlrc` | `~/.config/curlrc` | curl config |
| `wgetrc` | `~/.config/wgetrc` | wget config |
| `inputrc` | `~/.config/inputrc` | Readline (Vi mode) |
| `npmrc` | `~/.config/npmrc` | npm config |
| `yarnrc` | `~/.config/yarnrc` | yarn config |
| `gitconfig` | `~/.config/gitconfig` | git config |

## Runtime Management (mise)

mise replaces nvm + phpv:

| Runtime | Version | Backend | Method |
|---------|---------|---------|--------|
| Node.js | 24 LTS | `core` | Prebuilt binaries |
| PHP | 8.5 | `github:adwinying/php` | Precompiled static (no build deps) |

Config: `doti3/mise.toml` → symlinked to `~/.config/mise/config.toml`

```bash
mise use -g node@<version>
mise use -g github:adwinying/php@<version>
```

## Zsh Config Modules (`zsh/conf.d/`)

| File | Purpose |
|------|---------|
| `00-tmux.zsh` | Auto-start tmux (smart session management) |
| `01-options.zsh` | Shell options, history settings |
| `02-keybindings.zsh` | Vi mode, Emacs lifesavers, magic Ctrl+Z |
| `03-aliases.zsh` | bat (cat), eza (ls), jq, lazygit, yazi, Laravel, Docker, etc. |
| `04-mise-node.zsh` | Legacy NVM_DIR for compat |
| `05-tools.zsh` | zoxide, thefuck, navi, GCloud, uv |
| `06-mise.zsh` | mise activation + completions |
| `10-plugins.zsh` | zsh-autosuggestions, syntax-highlighting, Atuin+FZF |

## QoL Tools (in PACKAGES in deploy.sh)

| Tool | Function | Guarded? |
|------|----------|----------|
| **bat** | `cat` with syntax highlighting | Yes |
| **eza** | `ls` with icons, tree, git | Yes |
| **zoxide** | Smarter `cd` | Yes |
| **fd** | Fast `find` | System |
| **ripgrep** | Fast `grep` | System |
| **jq** | JSON processor | Alias only |

## Keybinds

### Screenshots
| Key | Action |
|-----|--------|
| `Mod+x` | Full screenshot |
| `Mod+Shift+x` | Window screenshot |
| `Mod+Ctrl+x` | Selection screenshot |
| `Mod+Ctrl+c` | Full to clipboard |
| `Mod+Ctrl+Shift+c` | Selection to clipboard |

### Clipboard & Notifications
| Key | Action |
|-----|--------|
| `Mod+c` | Clipboard history (clipmenu + rofi) |
| `Mod+d` | Notifications |
| `Mod+Shift+d` | Close notification |
| `Mod+Ctrl+d` | Close all notifications |
| `Mod+Shift+z` | History pop |

### Launcher & WM
| Key | Action |
|-----|--------|
| `Mod+space` | App launcher (rofi drun) |
| `Mod+Shift+t` | Window switcher (rofi) |
| `Mod+Return` | Terminal (kitty) |
| `Mod+q` | Kill window |
| `Mod+Shift+e` | Powermenu |
| `Mod+Escape` | Lock screen |
| `Mod+F1` | Key hint overlay |

### Display
| Key | Action |
|-----|--------|
| `Mod+Shift+a` | Auto-detect display |
| `Mod+Shift+s` | Single display |
| `Mod+Shift+p` | Choose layout |
| `Mod+m` | Mirror display |

## Systemd User Services

| Service | Purpose | Status |
|---------|---------|--------|
| `tmux.service` | Auto-start tmux on login | enabled |
| `clipmenud.service` | Clipboard manager daemon | enabled |

Config: `doti3/systemd/user/` → `~/.config/systemd/user/`

## Key Features
- XDG-compliant dirs (CONFIG_HOME, CACHE_HOME, DATA_HOME, STATE_HOME) via `.zshenv`
- Modular zsh via conf.d/ (no plugin manager)
- Desktop: i3 + polybar + picom + rofi + dunst + clipmenu
- Automatic display hotplug (udev rule)
- Backup on deploy (timestamped backups)
- mise for runtime versions (no more nvm/phpv compilation)
- Catppuccin Mocha theme throughout (kitty, tmux, starship, bat, yazi)
- JetBrainsMono Nerd Font everywhere
