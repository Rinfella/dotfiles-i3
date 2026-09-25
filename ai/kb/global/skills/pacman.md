---
description: Install or remove packages with pacman/yay
---

Install or remove packages on Arch Linux.

## Steps:
1. Ask for package name and action (install/remove).
2. Search for package: `pacman -Ss <package>` or `yay -Ss <package>`
3. Show package info before installing.
4. Install with pacman: `sudo pacman -S <package>`
5. Or with yay/AUR: `yay -S <package>`
6. Remove: `sudo pacman -R <package>` or `sudo pacman -Rns <package>` (with deps)

## Common Commands

```bash
# Search packages
pacman -Ss <search>
yay -Ss <search>

# Install
sudo pacman -S <package>
yay -S <package>

# Remove
sudo pacman -R <package>
sudo pacman -Rns <package>  # Remove with dependencies

# List installed
pacman -Qent  # Explicitly installed
pacman -Qdt  # Orphaned packages

# Clean cache
sudo pacman -Scc
```

## AUR Helpers
- yay, paru, trizen: Common AUR helpers