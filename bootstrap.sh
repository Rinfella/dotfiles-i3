#!/bin/bash
# doti3 Bootstrap Script
# Installs prerequisites, clones repo, and runs full setup
set -euo pipefail

echo "🚀 Installing prerequisites..."

# Install git if missing
if ! command -v git &>/dev/null; then
    echo "Installing git..."
    sudo pacman -S --noconfirm git
fi

# Install yay (AUR helper) if missing
if ! command -v yay &>/dev/null; then
    echo "Installing yay..."
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd - >/dev/null
    rm -rf /tmp/yay
fi

# Install mise if missing
if ! command -v mise &>/dev/null; then
    eecho "Installing mise..."
    curl https://mise.run | sh
    export PATH="$HOME/.local/share/mise/shims:$PATH"
fi

# Clone repo if not already present
if [[ ! -d "$HOME/.config/doti3" ]]; then
    echo "Cloning doti3 repo..."
    git clone https://github.com/Rinfella/dotfiles-i3.git "$HOME/.config/doti3"
fi

cd "$HOME/.config/doti3"

# Run full setup
echo "⚙️ Running full setup..."
mise run setup

echo "✅ Setup complete!"
