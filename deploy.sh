#!/bin/bash

CONFIG_DIR="$HOME/.config"
DOTI3_DIR="$CONFIG_DIR/doti3"

# Ensure the doti3 directory exists
mkdir -p "$DOTI3_DIR"

# List of config directories you want to manage
APPS=(i3 polybar fastfetch vim alacritty aws dunst easyeffects kitty zsh tmux nvim rofi picom yazi)

echo "🚀 Setting up directory-level symlinks..."

for app in "${APPS[@]}"; do
    TARGET_PATH="$CONFIG_DIR/$app"
    REPO_PATH="$DOTI3_DIR/$app"

    # Scenario 1: The folder exists in ~/.config but isn't in doti3 yet (Migration)
    if [ -d "$TARGET_PATH" ] && [ ! -L "$TARGET_PATH" ] && [ ! -d "$REPO_PATH" ]; then
        echo "📦 Moving $app to doti3..."
        mv "$TARGET_PATH" "$DOTI3_DIR/"
        
        echo "🔗 Symlinking $app..."
        ln -s "$REPO_PATH" "$TARGET_PATH"
        echo "✅ $app migrated and linked!"

    # Scenario 2: The folder is already in doti3, but the symlink is missing (Deployment on a new machine)
    elif [ -d "$REPO_PATH" ] && [ ! -L "$TARGET_PATH" ]; then
        # Back up existing unlinked config just in case
        if [ -d "$TARGET_PATH" ]; then
            mv "$TARGET_PATH" "${TARGET_PATH}.backup"
            echo "⚠️  Backed up existing $app to ${app}.backup"
        fi
        
        echo "🔗 Symlinking $app..."
        ln -s "$REPO_PATH" "$TARGET_PATH"
        echo "✅ $app linked!"

    # Scenario 3: It's already a symlink
    elif [ -L "$TARGET_PATH" ]; then
        echo "⏭️  $app is already symlinked. Skipping."
    
    else
        echo "⚠️  $app not found in ~/.config or doti3. Skipping."
    fi
done

# The special case: Symlink .zshenv to your home directory
if [ -f "$DOTI3_DIR/zsh/.zshenv" ]; then
    echo "🔗 Symlinking .zshenv to $HOME/.zshenv..."
    ln -sf "$DOTI3_DIR/zsh/.zshenv" "$HOME/.zshenv"
fi

echo "🎉 All done! Run 'ls -l ~/.config | grep doti3' to verify."
