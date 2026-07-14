#!/bin/bash
#
# doti3 Deployment Script
# Manages dotfile configurations via symlinks from central doti3 directory
#
# Usage: ./deploy.sh [--dry-run] [--install-deps]
#
# Features:
#   - Symlinks config directories from doti3 to ~/.config
#   - Symlinks specific config files (starship.toml, .zshenv, .screenlayout)
#   - Backs up existing configs before creating symlinks
#   - Skips missing apps gracefully
#   - Optional dependency installation
#   - Optional dry-run mode
#

set -euo pipefail

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
CONFIG_DIR="$HOME/.config"
DOTI3_DIR="$CONFIG_DIR/doti3"
HOME_DOTFILES="$HOME/.screenlayout"
DOTFILE_FILES=(
    "$DOTI3_DIR/zsh/.zshenv:$HOME/.zshenv"
    "$DOTI3_DIR/starship.toml:$HOME/.config/starship.toml"
    "$DOTI3_DIR/screenlayout:$HOME/.screenlayout"
    # XDG_CONFIG_HOME files
    "$DOTI3_DIR/curlrc:$HOME/.config/.curlrc"
    "$DOTI3_DIR/wgetrc:$HOME/.config/wgetrc"
    "$DOTI3_DIR/inputrc:$HOME/.config/inputrc"
    "$DOTI3_DIR/npmrc:$HOME/.config/npmrc"
    "$DOTI3_DIR/yarnrc:$HOME/.config/yarnrc"
    "$DOTI3_DIR/gitconfig:$HOME/.config/gitconfig"
    # git XDG files
    "$DOTI3_DIR/git/gitignore_global:$HOME/.config/git/gitignore_global"
    # XDG_DATA_HOME directories
    "$DOTI3_DIR/easyeffects:$HOME/.local/share/easyeffects"
)

# List of config directories to manage (in ~/.config/)
APPS=(
    ai
    alacritty
    atuin
    autotiling
    bat
    dunst
    fastfetch
    fontconfig
    git
    i3
    kitty
    mise
    nvim
    opencode
    picom
    polybar
    ripgrep
    rofi
    systemd
    tmux
    vim
    X11
    yazi
    zsh
)

# Packages to install (Arch Linux)
PACKAGES=(
    i3-wm
    picom
    polybar
    rofi
    dunst
    alacritty
    kitty
    yazi
    tmux
    neovim
    vim
    fastfetch
    starship
    atuin
    fzf
    thefuck
    navi
    lazygit
    blueman
    brightnessctl
    playerctl
    maim
    xdotool
    autotiling
    feh
    thunar
    easyeffects
    imagemagick
    i3blocks
    polkit-gnome
    network-manager-applet
    clipmenu
    # QoL tools
    bat
    eza
    fd
    jq
    ripgrep
    zoxide
    fzf
    atuin
    git-delta
    direnv
    glow
    lazydocker
    duf
    zsh-history-substring-search
    # Runtime version management
    mise
    re2c
)

# Parse arguments
DRY_RUN=false
INSTALL_DEPS=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --dry-run)
            DRY_RUN=true
            shift
            ;;
        --install-deps)
            INSTALL_DEPS=true
            shift
            ;;
        --help|-h)
            echo "Usage: $0 [--dry-run] [--install-deps]"
            echo ""
            echo "Options:"
            echo "  --dry-run       Show what would be done without making changes"
            echo "  --install-deps Install required packages (requires sudo)"
            echo "  --help, -h      Show this help message"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use --help for usage information"
            exit 1
            ;;
    esac
done

# Helper functions
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[OK]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

run_cmd() {
    if [[ "$DRY_RUN" == "true" ]]; then
        echo -e "${YELLOW}[DRY-RUN]${NC} Would execute: $*"
    else
        eval "$@"
    fi
}

# Pre-flight checks
log_info "Checking doti3 directory..."
if [[ ! -d "$DOTI3_DIR" ]]; then
    log_error "doti3 directory not found at $DOTI3_DIR"
    exit 1
fi
log_success "doti3 directory found"

# Install dependencies if requested
if [[ "$INSTALL_DEPS" == "true" ]]; then
    log_info "Checking for missing packages..."
    MISSING=()
    for pkg in "${PACKAGES[@]}"; do
        if ! pacman -Qq "$pkg" &>/dev/null; then
            MISSING+=("$pkg")
        fi
    done
    
    if [[ ${#MISSING[@]} -gt 0 ]]; then
        log_warn "Missing packages: ${MISSING[*]}"
        log_info "Installing missing packages with sudo..."
        run_cmd sudo pacman -S --noconfirm "${MISSING[@]}"
    else
        log_success "All required packages are installed"
    fi
fi

# ============================================
# Handle directory-based configs (~/.config/)
# ============================================
log_info "Setting up config directory symlinks..."

for app in "${APPS[@]}"; do
    TARGET_PATH="$CONFIG_DIR/$app"
    REPO_PATH="$DOTI3_DIR/$app"
    
    # Check if config exists in doti3
    if [[ ! -e "$REPO_PATH" ]]; then
        log_warn "$app not found in doti3. Skipping."
        continue
    fi
    
    # Scenario 1: Target is a regular directory (needs backup and symlink)
    if [[ -d "$TARGET_PATH" ]] && [[ ! -L "$TARGET_PATH" ]]; then
        BACKUP_PATH="${TARGET_PATH}.backup-$(date +%Y%m%d_%H%M%S)"
        log_warn "$app exists in ~/.config but is not a symlink."
        log_info "Backing up to $BACKUP_PATH"
        run_cmd mv "$TARGET_PATH" "$BACKUP_PATH"
        
        log_info "Symlinking $app..."
        run_cmd ln -s "$REPO_PATH" "$TARGET_PATH"
        log_success "$app migrated and linked!"
    
    # Scenario 2: Target is a symlink (already managed)
    elif [[ -L "$TARGET_PATH" ]]; then
        # Verify it points to doti3
        if [[ "$(readlink -f "$TARGET_PATH")" == "$REPO_PATH" ]]; then
            log_info "⏭️  $app is already symlinked to doti3. Skipping."
        else
            log_warn "$app is a symlink but points elsewhere: $(readlink "$TARGET_PATH")"
            log_info "Re-linking to doti3..."
            run_cmd rm "$TARGET_PATH"
            run_cmd ln -s "$REPO_PATH" "$TARGET_PATH"
            log_success "$app re-linked!"
        fi
    
    # Scenario 3: Target doesn't exist (new deployment)
    elif [[ ! -e "$TARGET_PATH" ]]; then
        log_info "Symlinking $app..."
        run_cmd ln -s "$REPO_PATH" "$TARGET_PATH"
        log_success "$app linked!"
    
    else
        log_warn "$app has unexpected state. Skipping."
    fi
done

# ============================================
# Handle file-based configs and home dotfiles
# ============================================
log_info "Setting up file symlinks..."

for entry in "${DOTFILE_FILES[@]}"; do
    SOURCE="${entry%%:*}"
    TARGET="${entry##*:}"
    
    if [[ ! -e "$SOURCE" ]]; then
        log_warn "Source file/dir not found: $SOURCE. Skipping."
        continue
    fi
    
    if [[ -e "$TARGET" ]] && [[ ! -L "$TARGET" ]]; then
        BACKUP_PATH="${TARGET}.backup-$(date +%Y%m%d_%H%M%S)"
        log_warn "$TARGET exists and is not a symlink."
        log_info "Backing up to $BACKUP_PATH"
        run_cmd mv "$TARGET" "$BACKUP_PATH"
    fi
    
    if [[ -L "$TARGET" ]]; then
        if [[ "$(readlink -f "$TARGET")" == "$(readlink -f "$SOURCE")" ]]; then
            log_info "⏭️  $TARGET is already correctly symlinked. Skipping."
            continue
        else
            run_cmd rm "$TARGET"
        fi
    fi
    
    # Ensure target parent directory exists
    TARGET_PARENT="$(dirname "$TARGET")"
    if [[ ! -d "$TARGET_PARENT" ]]; then
        log_info "Creating target parent directory: $TARGET_PARENT"
        run_cmd mkdir -p "$TARGET_PARENT"
    fi

    log_info "Symlinking $TARGET..."
    run_cmd ln -s "$SOURCE" "$TARGET"
    log_success "$TARGET linked!"
done

# ============================================
# Install udev rule for monitor hotplug
# ============================================
log_info "Setting up udev rule for monitor hotplug..."

UDEV_RULE="/etc/udev/rules.d/99-monitor-hotplug.rules"

if [[ -f "$UDEV_RULE" ]]; then
    log_info "udev rule already exists. Skipping."
else
    log_info "Creating udev rule..."
    if [[ "$DRY_RUN" == "true" ]]; then
        echo -e "${YELLOW}[DRY-RUN]${NC} Would create: $UDEV_RULE"
    else
        printf 'ACTION=="change", SUBSYSTEM=="drm", RUN+="/usr/bin/su rf -c ~/.config/i3/scripts/autodetect-display"\n' | sudo tee "$UDEV_RULE" > /dev/null
        sudo udevadm control --reload-rules
        log_success "udev rule created and reloaded!"
    fi
fi

# ============================================
# Reload and enable systemd user services
# ============================================
log_info "Setting up systemd user services..."

if [[ "$DRY_RUN" == "true" ]]; then
    echo -e "${YELLOW}[DRY-RUN]${NC} Would reload systemd user daemon and enable service units"
else
    systemctl --user daemon-reload
    for svc in "$CONFIG_DIR"/systemd/user/*.service; do
        if [[ -f "$svc" ]]; then
            svc_name=$(basename "$svc")
            log_info "Enabling systemd user service: $svc_name"
            systemctl --user enable "$svc_name" >/dev/null 2>&1 || log_warn "Failed to enable $svc_name"
        fi
    done
    log_success "systemd user services reloaded and enabled!"
fi

# ============================================
# Summary
# ============================================
echo ""
echo "=========================================="
echo -e "${GREEN}🎉 Deployment complete!${NC}"
echo "=========================================="
echo ""
echo "Managed configs:"
for app in "${APPS[@]}"; do
    TARGET_PATH="$CONFIG_DIR/$app"
    if [[ -L "$TARGET_PATH" ]]; then
        echo "  ✓ $app"
    fi
done

echo ""
echo "File symlinks:"
for entry in "${DOTFILE_FILES[@]}"; do
    TARGET="${entry##*:}"
    if [[ -L "$TARGET" ]]; then
        echo "  ✓ $TARGET"
    fi
done

echo ""
if [[ "$DRY_RUN" == "true" ]]; then
    echo -e "${YELLOW}This was a dry run. No changes were made.${NC}"
else
    echo "Run 'ls -la ~/.config | grep doti3' to verify symlinks."
fi
