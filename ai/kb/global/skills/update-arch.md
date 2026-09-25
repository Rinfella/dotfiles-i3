---
description: Updates Arch Linux system packages safely
---

Update system packages using pacman.

## Steps:
1. Check for package updates: `pacman -Sy`
2. Show summary of updates.
3. Ask for confirmation before upgrading.
4. Run upgrade: `sudo pacman -Syu`
5. Handle conflicts if any.

## Constraints:
- Always backup before major updates.
- Check news: `pacman -Pn`
- For AUR, use yay/paru: `yay -Syu`