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
| **Neovim** | [`nvim/`](./nvim/README.md) | Lazy.nvim, LSP, Obsidian note-taking, diagnostic & quickfix jumps |
| **Tmux** | [`tmux/`](./tmux/README.md) | Multiplexer, session persistence, Vim navigation, `Prefix+F` project switcher |
| **Yazi** | [`yazi/`](./yazi/README.md) | Rust TUI file manager, `Ctrl+Y` picker, and shell `y` wrapper |
| **Zsh** | [`zsh/`](./zsh/README.md) | Modular shell, Catppuccin theme tokens, `navi` widget (`Ctrl+G`), `atuin` |
| **Picom** | [`picom/`](./picom/README.md) | Compositor, dual-kawase blur, rounded corners (8px), fading |
| **Polybar** | [`polybar/`](./polybar/README.md) | Status bar modules, audio/brightness scrolls |
| **Dunst** | [`dunst/`](./dunst/README.md) | Notification daemon shortcuts & history |
| **Kitty** | [`kitty/`](./kitty/README.md) | Primary GPU terminal keybinds |
| **Alacritty** | [`alacritty/`](./alacritty/README.md) | Secondary terminal config |
| **Mise** | [`mise/`](./mise/README.md) | Universal runtime versions, task runner, and dotfiles management |
| **Lazygit** | [`lazygit/`](./lazygit/README.md) | Git TUI, Catppuccin Mocha theme, delta diff pager |
| **Atuin** | [`atuin/`](./atuin/README.md) | SQLite shell history search (`Ctrl+R`) |
| **Bat** | [`bat/`](./bat/README.md) | Highlighted file viewer and alias helpers |
| **Rofi** | [`rofi/`](./rofi/README.md) | Application launcher, window switcher, powermenu |
| **EasyEffects** | [`easyeffects/`](./easyeffects/README.md) | PipeWire audio processing & service controls |
| **RBW** | [`rbw/`](./rbw/README.md) | Bitwarden / Vaultwarden CLI & Rofi picker (`Mod+p`) |
| **Ripgrep** | [`ripgrep/`](./ripgrep/README.md) | Global `rg` configuration and flags |
| **Screenlayout** | [`screenlayout/`](./screenlayout/README.md) | Multi-monitor xrandr scripts & hotplug |
| **Systemd** | [`systemd/`](./systemd/README.md) | User service units (`easyeffects`, `omniroute`) |
| **Vim** | [`vim/`](./vim/README.md) | Lightweight fallback editor config |
| **Wireplumber** | [`wireplumber/`](./wireplumber/README.md) | PipeWire device rename and priority rules |
| **Composer** | [`composer/`](./composer/README.md) | Global PHP dependencies |
| **Fastfetch** | [`fastfetch/`](./fastfetch/README.md) | System banner configuration |
| **Fontconfig** | [`fontconfig/`](./fontconfig/README.md) | Subpixel font rendering & JetBrains Mono rules |
| **Git** | [`git/`](./git/README.md) | Global gitignore and author defaults |
| **Autostart** | [`autostart/`](./autostart/README.md) | XDG graphical login autostart desktop entries |
| **NWG-Look** | [`nwg-look/`](./nwg-look/README.md) | GTK theme configurator |
| **XSettingsd** | [`xsettingsd/`](./xsettingsd/README.md) | Lightweight XSETTINGS daemon for X11 GTK styling |
| **X11** | [`X11/`](./X11/README.md) | Xresources DPI and antialiasing database |
| **AI Hub** | [`ai/`](./ai/README.md) | Central knowledge base, MCP servers, and agent rules |

---

## ⚙️ Direct Root Configuration Files

The following configuration files reside directly in the root of `doti3/` and are symlinked via `mise dot apply`:

| File | Target Symlink | Description |
|------|---------------|-------------|
| `starship.toml` | `~/.config/starship.toml` | Cross-shell prompt theme (Catppuccin Mocha palette, Git branch & status, runtime versions) |
| `gitconfig` | `~/.config/gitconfig` | Global Git configuration (default branch `main`, delta pager integration, aliases) |
| `inputrc` | `~/.config/inputrc` | GNU Readline configuration (case-insensitive tab completion, vi/emacs editing modes) |
| `curlrc` | `~/.config/.curlrc` | Default curl flags (follows redirects `-L`, automatic retry, secure user agent) |
| `wgetrc` | `~/.config/wgetrc` | Default wget behavior (passive FTP, resume support, timeout limits) |
| `npmrc` | `~/.config/npmrc` | Global NPM configuration (XDG path conformance, prefix paths) |
| `yarnrc` | `~/.config/yarnrc` | Global Yarn cache and storage path overrides |
| `pavucontrol.ini` | `~/.config/pavucontrol.ini` | PulseAudio / PipeWire Volume Control window geometry & tab state |
| `mimeapps.list` | `~/.config/mimeapps.list` | XDG default application associations (browsers, editors, image viewers) |
| `deploy.sh` | — | Legacy bash deployment script with rotational backups (superseded by `mise dot apply`) |
| `bootstrap.sh` | — | Cold-start one-liner bootstrap script for fresh Arch-based Linux machines |

---

## Architecture & Bootstrapping

For full technical specifications on the `mise`-driven bootstrap architecture, see [`ai/kb/project/plans/2026-09-29-bootstrap-mise-dotfiles.md`](./ai/kb/project/plans/2026-09-29-bootstrap-mise-dotfiles.md).
