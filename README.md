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
| easyeffects | `easyeffects/` | Audio equalizer |
| easyeffects-data | `easyeffects-data/` | EQ presets |

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

# 5. Restart i3
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
| `Print` | Full screen save |
| `Mod+Print` | Active window save |
| `Shift+Print` | Selection save |
| `Ctrl+Print` | Full screen to clipboard |
| `Ctrl+Shift+Print` | Selection to clipboard |

Hot-plug detection is automatic via udev rule.

## Directory Structure

```
doti3/
├── deploy.sh              # Deployment script
├── starship.toml          # Starship prompt
├── easyeffectsrc          # EasyEffects UI config
├── easyeffects-data/      # EasyEffects presets
├── curlrc                 # curl config
├── wgetrc                 # wget config
├── gitconfig              # git config
├── inputrc                # readline config
├── npmrc                  # npm config
├── yarnrc                 # yarn config
├── alacritty/
├── atuin/
├── autostart/
├── dunst/
├── easyeffects/
├── fastfetch/
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
├── screenlayout/
├── rofi-themes/
├── tmux/
├── vim/
├── yazi/
└── zsh/
    ├── .zshenv
    └── conf.d/
```

## Recommended Additional Tools

These tools are not included in the repo but are recommended for better workflow:

```bash
# Install via pacman
sudo pacman -S zoxide eza bottom

# zoxide - smarter cd (integrates with nvim, zsh)
# eza - modern ls replacement with icons
# bottom - cross-platform system monitor
```

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