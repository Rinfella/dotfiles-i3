# Plan: One-liner Bootstrap + mise Dotfile Migration

**Date:** 2026-09-29
**Scope:** Arch-based Linux (vanilla Arch / EndeavourOS / Manjaro)

---

## Goal

Replace `deploy.sh` as the primary dotfile/package manager with a two-part system:

1. **`bootstrap.sh`** — a minimal, curl-safe script that handles the cold-start problem:
   installs `git`, `yay`, and `mise`, then clones `doti3`, and delegates everything else to mise.
2. **`mise.toml` tasks + `[dotfiles]` block** — mise owns package installs, symlink management,
   and verification going forward. `deploy.sh` is kept but deprecated (safety net only).

**Entry point on fresh machine:**
```bash
curl -fsSL https://raw.githubusercontent.com/<user>/doti3/main/bootstrap.sh | bash
```

---

## Architecture

### Files to Create/Modify

| File | Action | Responsibility |
|------|--------|----------------|
| `bootstrap.sh` | **Create** | Cold-start: git + yay + mise install, clone repo, call `mise run setup` |
| `mise/config.toml` | **Modify** | Add `[dotfiles]` block + `[tasks]` for packages, symlinks, verify, cron |
| `README.md` | **Modify** | Update quick-start to one-liner, document new workflow |

`deploy.sh` is **NOT deleted** — it is preserved as a legacy fallback.

---

## Bootstrap Sequence (what runs on a fresh machine)

```
curl bootstrap.sh
    │
    ├─ 1. pacman -S --needed git base-devel    (only deps for yay build)
    ├─ 2. Clone + build yay from AUR            (if yay not present)
    ├─ 3. yay -S mise                           (installs mise via AUR/official)
    ├─ 4. git clone doti3 → ~/.config/doti3     (if not already present)
    └─ 5. mise run setup                        (delegates everything to mise tasks)
             │
             ├─ mise run packages               (yay -S all PACKAGES)
             ├─ mise dot apply                  (symlink all dotfiles via [dotfiles])
             ├─ mise run cron                   (install crontab entries)
             ├─ mise run udev                   (write udev hotplug rule)
             └─ mise run verify                 (smoke test: i3 -C, nvim, rofi)
```

---

## Task Breakdown

### Task 1 — Write `bootstrap.sh`

**File:** `doti3/bootstrap.sh`

Must be:
- Idempotent (safe to run on already-set-up machines)
- curl-pipe safe (no interactive prompts unless unavoidable)
- Minimal — only does what mise cannot do before mise exists

Steps:
1. Print banner with warning ("This will set up your doti3 environment")
2. Check if running as root → abort (must run as user)
3. `sudo pacman -S --needed --noconfirm git base-devel`
4. If `yay` not in PATH: clone `https://aur.archlinux.org/yay.git` to `/tmp/yay`, `makepkg -si --noconfirm`
5. If `mise` not in PATH: `yay -S --noconfirm mise`
6. If `~/.config/doti3` not present (or empty): `git clone <REPO_URL> ~/.config/doti3`
7. `eval "$(mise activate bash)"` to make mise available in current shell
8. `cd ~/.config/doti3 && mise run setup`
9. Print final instructions (restart shell, log out/in for i3 to start)

**REPO_URL** must be defined at top of script as a variable — easy to change.

---

### Task 2 — Add `[tasks]` to `mise/config.toml`

**File:** `doti3/mise/config.toml`

Add the following task definitions. These replace the bash functions in `deploy.sh`.

```toml
[tasks.setup]
description = "Full setup: packages + dotfiles + cron + udev + verify"
depends = ["packages", "dotfiles", "cron", "udev", "verify"]
run = "echo 'Setup complete. Restart your shell.'"

[tasks.packages]
description = "Install all packages via yay"
run = """
yay -S --needed --noconfirm \
  i3-wm picom polybar rofi dunst alacritty kitty yazi tmux \
  neovim vim fastfetch starship fzf thefuck navi lazygit \
  blueman brightnessctl playerctl maim xdotool feh thunar \
  easyeffects imagemagick i3blocks polkit-gnome network-manager-applet \
  clipmenu rbw rofi-rbw composer php \
  bat eza fd jq ripgrep zoxide git-delta direnv glow lazydocker duf \
  zsh-history-substring-search re2c
"""

[tasks.dotfiles]
description = "Apply dotfile symlinks via mise dot apply"
run = "mise dot apply"

[tasks.cron]
description = "Install crontab entries from doti3/cron/"
run = """
if [ -d "$HOME/.config/doti3/cron" ]; then
  cat "$HOME/.config/doti3/cron/"* | crontab -
fi
"""

[tasks.udev]
description = "Install udev hotplug rule for monitor detection"
run = """
RULE_SRC="$HOME/.config/doti3/X11/udev/99-monitor-hotplug.rules"
RULE_DST="/etc/udev/rules.d/99-monitor-hotplug.rules"
if [ -f "$RULE_SRC" ]; then
  sudo cp "$RULE_SRC" "$RULE_DST"
  sudo udevadm control --reload-rules
fi
"""

[tasks.verify]
description = "Smoke-test configs: i3, rofi, nvim"
run = """
i3 -C && echo "i3 config OK"
nvim --headless +q 2>/dev/null && echo "nvim OK"
"""
```

---

### Task 3 — Add `[dotfiles]` block to `mise/config.toml`

This replaces the `DOTFILE_FILES` and `APPS` arrays in `deploy.sh`.

```toml
[settings]
dotfiles.root = "~/.config/doti3"

[dotfiles]
# Home directory files
"~/.zshenv"                  = { source = "zsh/.zshenv", mode = "symlink" }
"~/.screenlayout"            = { source = "screenlayout", mode = "symlink" }

# XDG_CONFIG_HOME flat files
"~/.config/starship.toml"           = { source = "starship.toml", mode = "symlink" }
"~/.config/.curlrc"                 = { source = "curlrc", mode = "symlink" }
"~/.config/wgetrc"                  = { source = "wgetrc", mode = "symlink" }
"~/.config/inputrc"                 = { source = "inputrc", mode = "symlink" }
"~/.config/npmrc"                   = { source = "npmrc", mode = "symlink" }
"~/.config/yarnrc"                  = { source = "yarnrc", mode = "symlink" }
"~/.config/gitconfig"               = { source = "gitconfig", mode = "symlink" }
"~/.config/mimeapps.list"           = { source = "mimeapps.list", mode = "symlink" }
"~/.config/pavucontrol.ini"         = { source = "pavucontrol.ini", mode = "symlink" }
"~/.config/composer/composer.json"  = { source = "composer/composer.json", mode = "symlink" }
"~/.config/composer/composer.lock"  = { source = "composer/composer.lock", mode = "symlink" }

# XDG_CONFIG_HOME directories
"~/.config/ai"          = { source = "ai", mode = "symlink" }
"~/.config/alacritty"   = { source = "alacritty", mode = "symlink" }
"~/.config/atuin"       = { source = "atuin", mode = "symlink" }
"~/.config/autostart"   = { source = "autostart", mode = "symlink" }
"~/.config/bat"         = { source = "bat", mode = "symlink" }
"~/.config/dunst"       = { source = "dunst", mode = "symlink" }
"~/.config/fastfetch"   = { source = "fastfetch", mode = "symlink" }
"~/.config/fontconfig"  = { source = "fontconfig", mode = "symlink" }
"~/.config/git"         = { source = "git", mode = "symlink" }
"~/.config/gtk-2.0"     = { source = "gtk-2.0", mode = "symlink" }
"~/.config/gtk-3.0"     = { source = "gtk-3.0", mode = "symlink" }
"~/.config/gtk-4.0"     = { source = "gtk-4.0", mode = "symlink" }
"~/.config/i3"          = { source = "i3", mode = "symlink" }
"~/.config/kitty"       = { source = "kitty", mode = "symlink" }
"~/.config/lazygit"     = { source = "lazygit", mode = "symlink" }
"~/.config/mise"        = { source = "mise", mode = "symlink" }
"~/.config/nvim"        = { source = "nvim", mode = "symlink" }
"~/.config/nwg-look"    = { source = "nwg-look", mode = "symlink" }
"~/.config/opencode"    = { source = "opencode", mode = "symlink" }
"~/.config/picom"       = { source = "picom", mode = "symlink" }
"~/.config/polybar"     = { source = "polybar", mode = "symlink" }
"~/.config/rbw"         = { source = "rbw", mode = "symlink" }
"~/.config/ripgrep"     = { source = "ripgrep", mode = "symlink" }
"~/.config/rofi"        = { source = "rofi", mode = "symlink" }
"~/.config/systemd"     = { source = "systemd", mode = "symlink" }
"~/.config/tmux"        = { source = "tmux", mode = "symlink" }
"~/.config/vim"         = { source = "vim", mode = "symlink" }
"~/.config/wireplumber" = { source = "wireplumber", mode = "symlink" }
"~/.config/X11"         = { source = "X11", mode = "symlink" }
"~/.config/xsettingsd"  = { source = "xsettingsd", mode = "symlink" }
"~/.config/yazi"        = { source = "yazi", mode = "symlink" }
"~/.config/zsh"         = { source = "zsh", mode = "symlink" }

# XDG_DATA_HOME directories
"~/.local/share/easyeffects"    = { source = "easyeffects", mode = "symlink" }
"~/.local/share/rofi/themes"    = { source = "rofi-themes", mode = "symlink" }
```

---

### Task 4 — Update `README.md`

Replace the current "Clone & deploy" block with:

```markdown
## Quick Start (Fresh Machine)

```bash
curl -fsSL https://raw.githubusercontent.com/<user>/doti3/main/bootstrap.sh | bash
```

That's it. The script will:
1. Install `git`, `yay` (AUR helper)
2. Install `mise`
3. Clone this repo to `~/.config/doti3`
4. Run `mise run setup` (packages → dotfiles → cron → udev → verify)

## Day-to-day

| Task | Command |
|------|---------|
| Apply dotfile symlinks | `mise dot apply` |
| Check symlink status   | `mise dot status` |
| Install packages       | `mise run packages` |
| Verify configs         | `mise run verify` |
| Install crontab        | `mise run cron` |
```

---

## What We Lose from `deploy.sh` (and how to handle it)

| Feature | `deploy.sh` | `mise` replacement |
|---------|------------|-------------------|
| Rotational backups (keep 3) | Yes | No native equivalent — `mise dot apply` errors on conflict. Mitigation: bootstrap.sh backs up `~/.config` before first apply |
| `--dry-run` mode | `--dry-run` flag | `mise dot apply --dry-run` (native) |
| `--prune` stale symlinks | `--prune` flag | `mise dot unapply` + re-apply |
| Graceful skip missing apps | Yes | mise errors on missing source — must keep sources in repo |
| `--verify` smoke tests | `--verify` flag | `mise run verify` task |

### Mitigation for lost backups

In `bootstrap.sh`, before calling `mise dot apply`, snapshot existing configs:
```bash
[ -d ~/.config ] && cp -r ~/.config ~/.config.bak-$(date +%Y%m%d%H%M%S)
```
One backup per bootstrap run is sufficient for a fresh machine scenario.

---

## Testing / Verification

After implementation, test by simulating a cold-start in a container or VM:

```bash
# Quick local test (does NOT run as root, skips yay install)
bash -x bootstrap.sh
mise dot status       # all should show "linked"
mise run verify       # i3 + nvim smoke tests
```

---

## Open Questions / Caveats

- `mise dot apply` behavior on symlink conflicts needs to be confirmed (does it error or skip?)
- `bootstrap.sh` REPO_URL must be updated to actual GitHub URL before use
- `~/.config/mise` symlink pointing into doti3 creates a self-referencing situation — mise reads
  its config from `~/.config/mise/config.toml` which will be the symlink. Verify this works as
  expected on a clean machine (it should, since symlink resolves before mise reads it).
