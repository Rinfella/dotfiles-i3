---
description: Backs up and restores dotfiles/configs
---

Back up and restore dotfiles and configuration files.

## Steps:
1. Ask for action (backup/restore/list).
2. Execute appropriate command.

## Common Commands

```bash
# List dotfiles
ls -la ~
ls -la ~/.config/

# Backup to git repo
cd ~
git init --bare $HOME/.dotfiles
git add .bashrc .zshrc .gitconfig .vim/
git commit -m "Add dotfiles"

# Using Stow (already in your setup)
cd ~/.config/opencode/blueprint
stow -t ~ .bashrc .zshrc

# Restore from backup
cp ~/.dotfiles/backup/.bashrc ~
source ~/.bashrc

# Config directories
~/.config/      # User configs
~/.local/bin/   # User binaries
~/.local/share/ # User data
```

## Important Dotfiles
- `.bashrc`, `.zshrc` - Shell
- `.gitconfig` - Git
- `.vim/` - Vim
- `.config/opencode/` - OpenCode config
- `.ssh/` - SSH keys (sensitive!)