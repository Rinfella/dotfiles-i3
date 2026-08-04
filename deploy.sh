#!/bin/bash
#
# doti3 Deployment Script
# Manages dotfile configurations via symlinks from central doti3 directory
#
# Usage: ./deploy.sh [--dry-run] [--install-deps] [--verify] [--prune]
#
# Features:
#   - Symlinks config directories from doti3 to ~/.config
#   - Symlinks specific config files (starship.toml, .zshenv, .screenlayout)
#   - Backs up existing configs before creating symlinks (rotates, keeps 3)
#   - Skips missing apps gracefully
#   - Optional dependency installation
#   - Optional verification (symlink integrity + config smoke tests)
#   - Optional prune of stale doti3 symlinks
#   - Installs cron entries from doti3/cron
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
USERNAME="${SUDO_USER:-$USER}"
BACKUP_KEEP=3

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
    "$DOTI3_DIR/mimeapps.list:$HOME/.config/mimeapps.list"
    "$DOTI3_DIR/pavucontrol.ini:$HOME/.config/pavucontrol.ini"
    # git XDG files (git/ dir fully managed via APPS)
    # Composer global manifest (auth.json stays local, never tracked)
    "$DOTI3_DIR/composer/composer.json:$HOME/.config/composer/composer.json"
    "$DOTI3_DIR/composer/composer.lock:$HOME/.config/composer/composer.lock"
    # XDG_DATA_HOME directories
    "$DOTI3_DIR/easyeffects:$HOME/.local/share/easyeffects"
    # Rofi themes shared dir
    "$DOTI3_DIR/rofi-themes:$HOME/.local/share/rofi/themes"
)

# List of config directories to manage (in ~/.config/)
APPS=(
    ai
    alacritty
    atuin
    autostart
    bat
    dunst
    fastfetch
    fontconfig
    git
    gtk-2.0
    gtk-3.0
    gtk-4.0
    i3
    kitty
    lazygit
    easyeffects
    mise
    nvim
    nwg-look
    opencode
    picom
    polybar
    rbw
    ripgrep
    rofi
    systemd
    tmux
    vim
    xsettingsd
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
    fzf
    thefuck
    navi
    lazygit
    blueman
    brightnessctl
    playerctl
    maim
    xdotool
    feh
    thunar
    easyeffects
    imagemagick
    i3blocks
    polkit-gnome
    network-manager-applet
    clipmenu
    rbw
    rofi-rbw
    composer
    php
    # QoL tools
    bat
    eza
    fd
    jq
    ripgrep
    zoxide
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
VERIFY=false
PRUNE=false

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
        --verify)
            VERIFY=true
            shift
            ;;
        --prune)
            PRUNE=true
            shift
            ;;
        --help|-h)
            echo "Usage: $0 [--dry-run] [--install-deps] [--verify] [--prune]"
            echo ""
            echo "Options:"
            echo "  --dry-run       Show what would be done without making changes"
            echo "  --install-deps  Install required packages (requires sudo)"
            echo "  --verify        Check symlink integrity + smoke-test configs"
            echo "  --prune         Remove stale doti3 symlinks not in APPS/DOTFILE lists"
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
        "$@"
    fi
}

rotate_backups() {
    local base="$1"
    local backups
    backups=$(ls -d "${base}.backup-"* 2>/dev/null | sort -r || true)
    local count=0
    for b in $backups; do
        count=$((count + 1))
        if [[ $count -gt $BACKUP_KEEP ]]; then
            log_info "Rotating out old backup: $b"
            run_cmd rm -rf "$b"
        fi
    done
}

in_list() {
    local needle="$1"
    shift
    local item
    for item in "$@"; do
        [[ "$item" == "$needle" ]] && return 0
    done
    return 1
}

# Pre-flight checks
log_info "Checking doti3 directory..."
if [[ ! -d "$DOTI3_DIR" ]]; then
    log_error "doti3 directory not found at $DOTI3_DIR"
    exit 1
fi
if [[ ! -d "$DOTI3_DIR/.git" ]]; then
    log_warn "doti3 is not a git repository. Reproducibility not verifiable."
fi
log_success "doti3 directory found"

# Install dependencies if requested
if [[ "$INSTALL_DEPS" == "true" ]]; then
    if [[ -z "${XDG_RUNTIME_DIR:-}" ]] || ! sudo -n true 2>/dev/null; then
        log_warn "--install-deps needs interactive sudo; run it from a terminal session."
    fi
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
        log_warn "$app exists in ~/.config but is not a symlink."
        log_info "Backing up to ${TARGET_PATH}.backup-$(date +%Y%m%d_%H%M%S)"
        run_cmd mv "$TARGET_PATH" "${TARGET_PATH}.backup-$(date +%Y%m%d_%H%M%S)"

        log_info "Symlinking $app..."
        run_cmd ln -s "$REPO_PATH" "$TARGET_PATH"
        log_success "$app migrated and linked!"
        rotate_backups "$TARGET_PATH"

    # Scenario 2: Target is a symlink (already managed)
    elif [[ -L "$TARGET_PATH" ]]; then
        # Verify it points to doti3
        if [[ "$(readlink -f "$TARGET_PATH")" == "$REPO_PATH" ]]; then
            log_info "Skipping $app — already symlinked to doti3."
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

    # Scenario 4: Target is a regular file where dir expected
    elif [[ -f "$TARGET_PATH" ]]; then
        log_warn "$app is a regular file at $TARGET_PATH — expected directory. Manual intervention required."

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
        rotate_backups "$TARGET"
    fi

    if [[ -L "$TARGET" ]]; then
        if [[ "$(readlink -f "$TARGET")" == "$(readlink -f "$SOURCE")" ]]; then
            log_info "Skipping $TARGET — already correctly symlinked."
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

if [[ "$VERIFY" == "true" ]]; then
    log_info "Skipping udev rule setup in verify mode."
else
# ============================================
# Install udev rule for monitor hotplug
# ============================================
log_info "Setting up udev rule for monitor hotplug..."

UDEV_RULE="/etc/udev/rules.d/99-monitor-hotplug.rules"
UDEV_CMD="/usr/bin/su $USERNAME -c $HOME/.config/i3/scripts/autodetect-display"

if [[ -f "$UDEV_RULE" ]]; then
    if grep -q "autodetect-display" "$UDEV_RULE" 2>/dev/null && [[ "$(cat "$UDEV_RULE")" == *"$HOME/.config/i3"* ]]; then
        log_info "udev rule already present with expanded path. Skipping."
    else
        log_warn "udev rule exists but has stale/relative path. Updating..."
        if [[ "$DRY_RUN" == "true" ]]; then
            echo -e "${YELLOW}[DRY-RUN]${NC} Would rewrite: $UDEV_RULE"
        else
            printf 'ACTION=="change", SUBSYSTEM=="drm", RUN+="%s"\n' "$UDEV_CMD" | sudo tee "$UDEV_RULE" > /dev/null
            sudo udevadm control --reload-rules
            log_success "udev rule updated and reloaded!"
        fi
    fi
else
    log_info "Creating udev rule..."
    if [[ "$DRY_RUN" == "true" ]]; then
        echo -e "${YELLOW}[DRY-RUN]${NC} Would create: $UDEV_RULE"
    else
        printf 'ACTION=="change", SUBSYSTEM=="drm", RUN+="%s"\n' "$UDEV_CMD" | sudo tee "$UDEV_RULE" > /dev/null
        sudo udevadm control --reload-rules
        log_success "udev rule created and reloaded!"
    fi
fi


fi

if [[ "$VERIFY" == "true" ]]; then
    log_info "Skipping cron setup in verify mode."
else
# ============================================
# Install cron entries from doti3/cron
# ============================================
CRON_DIR="$DOTI3_DIR/cron"
if [[ -d "$CRON_DIR" ]]; then
    log_info "Setting up cron entries..."
    CURRENT_CRON="$(crontab -l 2>/dev/null || true)"
    INSTALLED=0
    for cronfile in "$CRON_DIR"/*; do
        [[ -f "$cronfile" ]] || continue
        while IFS= read -r line; do
            [[ -z "$line" ]] || [[ "$line" == \#* ]] && continue
            if grep -qF "$line" <<< "$CURRENT_CRON"; then
                log_info "Cron already present: $line"
            else
                log_info "Adding cron: $line"
                if [[ "$DRY_RUN" == "true" ]]; then
                    echo -e "${YELLOW}[DRY-RUN]${NC} Would add to crontab"
                else
                    (printf '%s\n' "$CURRENT_CRON" "$line" | crontab -)
                    CURRENT_CRON="$(crontab -l 2>/dev/null || true)"
                    INSTALLED=1
                fi
            fi
        done < "$cronfile"
    done
    if [[ $INSTALLED -eq 1 ]]; then
        log_success "Cron entries installed."
    else
        log_success "Cron entries already in place."
    fi
else
    log_info "No doti3/cron directory — skipping cron setup."
fi


fi

if [[ "$VERIFY" == "true" ]]; then
    log_info "Skipping systemd setup in verify mode."
else
# ============================================
# Reload and enable systemd user services
# ============================================
log_info "Setting up systemd user services..."

if [[ -z "${XDG_RUNTIME_DIR:-}" ]] || [[ ! -d "$XDG_RUNTIME_DIR" ]]; then
    log_warn "No user systemd session (XDG_RUNTIME_DIR missing). Skipping service setup."
else
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
        loginctl enable-linger "$USERNAME" 2>/dev/null && log_success "Linger enabled for $USERNAME"
    fi
fi


fi

if [[ "$VERIFY" == "true" ]]; then
    log_info "Skipping .env copy in verify mode."
else
# ============================================
# Copy .env.example → .env if missing
# ============================================
ENV_EXAMPLE="$DOTI3_DIR/i3/scripts/.env.example"
ENV_FILE="$DOTI3_DIR/i3/scripts/.env"
if [[ -f "$ENV_EXAMPLE" ]] && [[ ! -f "$ENV_FILE" ]]; then
    log_info "Copying .env.example to .env (edit with real values)..."
    run_cmd cp "$ENV_EXAMPLE" "$ENV_FILE"
elif [[ -f "$ENV_FILE" ]]; then
    log_info ".env already present. Skipping."
fi


fi

# ============================================
# Prune stale doti3 symlinks
# ============================================
if [[ "$PRUNE" == "true" ]]; then
    log_info "Pruning stale doti3 symlinks..."
    PRUNED=0
    for link in "$CONFIG_DIR"/*; do
        [[ -L "$link" ]] || continue
        target="$(readlink -f "$link")"
        [[ "$target" == "$DOTI3_DIR"/* ]] || continue
        name="$(basename "$link")"
        if in_list "$name" "${APPS[@]}"; then
            continue
        fi
        if in_list "$link" "${DOTFILE_FILES[@]##*:}"; then
            continue
        fi
        log_warn "Stale symlink: $link → $target"
        run_cmd rm "$link"
        PRUNED=1
    done
    if [[ $PRUNED -eq 0 ]]; then
        log_success "No stale symlinks found."
    fi
fi

# ============================================
# Verification
# ============================================
if [[ "$VERIFY" == "true" ]]; then
    log_info "Running verification..."
    FAILURES=0

    for app in "${APPS[@]}"; do
        [[ -e "$DOTI3_DIR/$app" ]] || continue
        if [[ -L "$CONFIG_DIR/$app" ]] && [[ "$(readlink -f "$CONFIG_DIR/$app")" == "$DOTI3_DIR/$app" ]]; then
            log_success "symlink OK: $app"
        else
            log_error "symlink BROKEN: $app"
            FAILURES=1
        fi
    done

    for entry in "${DOTFILE_FILES[@]}"; do
        TARGET="${entry##*:}"
        SOURCE="${entry%%:*}"
        [[ -e "$SOURCE" ]] || continue
        if [[ -L "$TARGET" ]] && [[ "$(readlink -f "$TARGET")" == "$(readlink -f "$SOURCE")" ]]; then
            log_success "symlink OK: $TARGET"
        else
            log_error "symlink BROKEN: $TARGET"
            FAILURES=1
        fi
    done

    if command -v i3 >/dev/null 2>&1; then
        if i3 -C "$DOTI3_DIR/i3/config" 2>/dev/null; then
            log_success "i3 config valid"
        else
            log_error "i3 config INVALID"
            FAILURES=1
        fi
    fi

    for theme in "$DOTI3_DIR"/rofi/*.rasi; do
        [[ -f "$theme" ]] || continue
        if rofi -theme "$theme" -dump-theme >/dev/null 2>&1; then
            log_success "rofi theme OK: $(basename "$theme")"
        else
            log_error "rofi theme INVALID: $(basename "$theme")"
            FAILURES=1
        fi
    done

    if command -v nvim >/dev/null 2>&1; then
        if nvim --headless +qa >/dev/null 2>&1; then
            log_success "nvim config loads"
        else
            log_error "nvim config FAILED to load"
            FAILURES=1
        fi
    fi

    if [[ $FAILURES -eq 0 ]]; then
        log_success "All verification checks passed."
    else
        log_error "Verification found problems. See above."
        exit 1
    fi
fi

# ============================================
# Summary
# ============================================
echo ""
echo "=========================================="
echo -e "${GREEN}Deployment complete!${NC}"
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
