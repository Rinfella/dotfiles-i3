# doti3 - Dotfiles Configuration

A reproducible, modular dotfiles setup for Arch-based Linux systems with i3wm.

## Overview

This repository manages configuration files for various tools via symlinks from a central `doti3` directory. It's designed to be easily reproducible on new machines.

## Managed Configurations

### Shell & Terminal
| Tool | Config Location | Description |
|------|-----------------|-------------|
| zsh | `zsh/` | Shell with conf.d modular config |
| starship | `starship.toml` | Prompt customization |
| atuin | `atuin/` | Shell history with sync |
| alacritty | `alacritty/` | GPU-accelerated terminal |
| kitty | `kitty/` | Terminal emulator |
| tmux | `tmux/` | Terminal multiplexer |
| bat | `bat/config` | Better cat with syntax highlighting |

### Window Manager & Desktop
| Tool | Config Location | Description |
|------|-----------------|-------------|
| i3 | `i3/` | Tiling window manager |
| polybar | `polybar/` | Status bar |
| picom | `picom/` | Compositor (transparency/blur) |
| rofi | `rofi/` | Application launcher |
| dunst | `dunst/` | Notification daemon |

### Editor & Development
| Tool | Config Location | Description |
|------|-----------------|-------------|
| nvim | `nvim/` | Neovim (LazyVim-style config) |
| vim | `vim/` | Vim config |
| opencode | `opencode/` | AI coding assistant |

### System Utilities
| Tool | Config Location | Description |
|------|-----------------|-------------|
| yazi | `yazi/` | Fast file manager |
| fastfetch | `fastfetch/` | System info fetch |
| screenlayout | `screenlayout/` | Display layouts |
| autostart | `autostart/` | Autostart desktop files |
| easyeffects | `easyeffects/` | Audio equalizer (presets + config) |
| fontconfig | `fontconfig/` | Font rendering configuration |
| X11 | `X11/` | X11 resources (cursor theme) |
| systemd | `systemd/user/` | User systemd services |

## Quick Start

### On a New Machine

```bash
# 1. Clone this repository
git clone https://github.com/yourusername/doti3.git ~/.config/doti3

# 2. Navigate to doti3 directory
cd ~/.config/doti3

# 3. Dry run to see what would happen
./deploy.sh --dry-run

# 4. Deploy with package installation (requires sudo)
./deploy.sh --install-deps

# 5. Start clipboard daemon (systemd user service)
systemctl --user enable --now clipmenud

# 6. Restart i3
i3-msg restart
```

### Available Options

```bash
./deploy.sh --help

Options:
  --dry-run       Show what would be done without making changes
  --install-deps  Install required packages (requires sudo)
  --help, -h      Show this help message
```

## Display Auto-Detection

Automatic display detection for laptops via HDMI + lid state:

- **No HDMI** → Built-in display only (`single.sh`)
- **HDMI + lid open** → Extended left (`extended-left.sh`)
- **HDMI + lid closed** → HDMI only (`hdmi-only.sh`)

### Keybinds
| Keybind | Action |
|---------|--------|
| `Mod+Shift+a` | Auto-detect display |
| `Mod+Shift+s` | Single display |
| `Mod+Shift+p` | Choose layout via menu |
| `Mod+m` | Mirror display |

### Screenshots
| Keybind | Action |
|---------|--------|
| `Mod+x` | Full screen save |
| `Mod+Shift+x` | Active window save |
| `Mod+Ctrl+x` | Selection save |
| `Mod+Ctrl+c` | Full screen to clipboard |
| `Mod+Ctrl+Shift+c` | Selection to clipboard |

### Clipboard Manager
| Keybind | Action |
|---------|--------|
| `Mod+c` | Clipboard history (clipmenu + rofi themed) |

`clipmenud` runs as a systemd user service:
```bash
systemctl --user enable --now clipmenud
```

Polybar shows a  clipboard icon (clickable):
- **Left-click** → themed rofi clipboard history (same as `Mod+c`)
- **Right-click** → pause clipboard tracking for 5s (clipctl toggle) — useful for copying sensitive data

### Notifications
| Keybind | Action |
|---------|--------|
| `Mod+d` | Notification context |
| `Mod+Shift+d` | Close notification |
| `Mod+Ctrl+d` | Close all notifications |
| `Mod+Shift+z` | History pop |

Hot-plug detection is automatic via udev rule.

## Directory Structure

```
doti3/
├── deploy.sh              # Deployment script
├── mise/                  # Runtime version management (config.toml)
├── starship.toml          # Starship prompt
├── easyeffects/           # EasyEffects audio presets + config
├── curlrc                 # curl config
├── wgetrc                 # wget config
├── gitconfig              # git config
├── inputrc                # readline config
├── npmrc                  # npm config
├── yarnrc                 # yarn config
├── alacritty/
├── atuin/
├── autostart/
├── bat/
├── dunst/
├── fastfetch/
├── fontconfig/
├── i3/
│   ├── config
│   └── scripts/
│       ├── autodetect-display
│       ├── screen-layout
│       └── ...
├── kitty/
├── nvim/
├── opencode/
├── picom/
├── polybar/
├── rofi/
│   ├── config.rasi         # Theme import (deep-purple)
│   ├── rofidmenu.rasi      # App launcher / window switcher
│   ├── clipmenu.rasi       # Clipboard history (clipmenu)
│   ├── powermenu.rasi
│   └── screen-layout.rasi
├── screenlayout/
├── rofi-themes/
├── systemd/user/          # User systemd services (tmux, clipmenud, easyeffects)
├── tmux/
├── vim/
├── X11/
├── yazi/
└── zsh/
    ├── .zshenv
    └── conf.d/
```

## Runtime Management

This repo uses **mise** to manage tool versions:

| Tool | Config | Managed Runtimes | Backend |
|------|--------|------------------|---------|
| mise | `mise/config.toml` → `~/.config/mise/config.toml` | Node.js (core, prebuilt), PHP (registry, community vfox) |

mise replaces the previous setup of nvm (Node) and phpv (PHP) with a single, unified tool.

| Runtime | Version | Backend |
|---------|---------|---------|
| Node.js | 24 (LTS) | `core` — prebuilt binaries |
| PHP | 8.5 | `php` (vfox-php) — precompiled community binaries |

To change versions:

```bash
mise use -g node@<version>
mise use -g php@<version>
```

## QoL Tools

Configured in `zsh/conf.d/`:

| Tool | Function |
|------|----------|
| **bat** | `cat` alternative with syntax highlighting, Catppuccin Mocha theme |
| **eza** | Modern `ls` with icons, tree view, git integration |
| **zoxide** | Smarter `cd` that learns your habits |
| **fd** | Fast `find` replacement |
| **ripgrep** | Fast `grep` replacement |
| **jq** | JSON processor |

## How It Works

1. **Directory-based configs** → Symlinked from `~/.config/doti3/` to `~/.config/`
2. **File-based configs** → Symlinked individually (`.zshenv`, `starship.toml`, etc.)
3. **Data directories** → Symlinked from `~/.local/share/` to `doti3/`
4. **Backup** → Existing configs are backed up with timestamp before symlinking

## Why Not GNU Stow?

Stow is not used because:
- Only handles directories, not individual files
- No backup mechanism for existing configs
- Doesn't support nested package structures
- Our deploy.sh is more flexible and tailored to this setup

## License

MIT