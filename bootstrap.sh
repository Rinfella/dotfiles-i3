#!/bin/bash
#
# doti3 Bootstrap Script
# One-liner fresh machine setup for Arch-based Linux (Arch, EndeavourOS, Manjaro, etc.)
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/Rinfella/dotfiles-i3/master/bootstrap.sh | bash
#
# What it does:
#   1. Installs git + base-devel via pacman (only hard prereqs)
#   2. Builds and installs yay (AUR helper) if not present
#   3. Installs mise via yay if not present
#   4. Clones doti3 repo to ~/.config/doti3 if not already there
#   5. Snapshots existing ~/.config as a backup
#   6. Delegates full setup to: mise run setup
#      (packages → dotfiles → env → cron → udev → systemd → verify)
#
# Idempotent: safe to re-run on an already configured machine.
#

set -euo pipefail

REPO_URL="https://github.com/Rinfella/dotfiles-i3.git"
DOTI3_DIR="$HOME/.config/doti3"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info()    { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[OK]${NC} $1"; }
log_warn()    { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error()   { echo -e "${RED}[ERROR]${NC} $1"; }

echo ""
echo "  ██████╗  ██████╗ ████████╗██╗██████╗ "
echo "  ██╔══██╗██╔═══██╗╚══██╔══╝██║╚════██╗"
echo "  ██║  ██║██║   ██║   ██║   ██║ █████╔╝"
echo "  ██║  ██║██║   ██║   ██║   ██║ ╚═══██╗"
echo "  ██████╔╝╚██████╔╝   ██║   ██║██████╔╝"
echo "  ╚═════╝  ╚═════╝    ╚═╝   ╚═╝╚═════╝ "
echo ""
echo "  Arch Linux + i3wm dotfiles bootstrap"
echo ""

# Safety: must not run as root
if [[ "$EUID" -eq 0 ]]; then
    log_error "Do not run this script as root. Run as your normal user."
    exit 1
fi

# Step 1: Install git + base-devel (prereqs for building yay)
log_info "Installing git and base-devel via pacman..."
sudo pacman -S --needed --noconfirm git base-devel
log_success "git + base-devel ready."

# Step 2: Install yay if not present
if ! command -v yay &>/dev/null; then
    log_info "yay not found. Building from AUR..."
    YAY_TMP=$(mktemp -d)
    git clone --depth=1 https://aur.archlinux.org/yay.git "$YAY_TMP/yay"
    (cd "$YAY_TMP/yay" && makepkg -si --noconfirm)
    rm -rf "$YAY_TMP"
    log_success "yay installed."
else
    log_success "yay already present: $(command -v yay)"
fi

# Step 3: Install mise if not present
if ! command -v mise &>/dev/null; then
    log_info "mise not found. Installing via yay..."
    yay -S --needed --noconfirm mise
    log_success "mise installed."
else
    log_success "mise already present: $(mise --version 2>&1 | head -1)"
fi

# Step 4: Clone doti3 repo if not already present
if [[ ! -d "$DOTI3_DIR/.git" ]]; then
    log_info "Cloning doti3 to $DOTI3_DIR..."
    git clone "$REPO_URL" "$DOTI3_DIR"
    log_success "doti3 cloned."
else
    log_success "doti3 already present at $DOTI3_DIR"
    log_info "Pulling latest changes..."
    git -C "$DOTI3_DIR" pull --ff-only || log_warn "Could not fast-forward pull. Check for local changes."
fi

# Step 5: Snapshot existing ~/.config before applying dotfiles
BACKUP_PATH="$HOME/.config-bootstrap-bak-$(date +%Y%m%d%H%M%S)"
log_info "Snapshotting existing ~/.config to $BACKUP_PATH ..."
cp -r "$HOME/.config" "$BACKUP_PATH"
log_success "Backup done: $BACKUP_PATH"

# Step 6: Activate mise in this shell session, then delegate to mise run setup
log_info "Activating mise and running full setup..."
eval "$(mise activate bash)"

cd "$DOTI3_DIR"
mise run setup

echo ""
log_success "Bootstrap complete!"
echo ""
echo "  Next steps:"
echo "  1. Restart your shell (or: source ~/.zshenv)"
echo "  2. Log out and back in to start i3"
echo "  3. Run: mise run verify   — to smoke-test configs"
echo ""
