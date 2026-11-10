# vim

Lightweight fallback editor configuration when Neovim is unavailable.

## Prerequisites
- `vim` (installed via system pacman)
- Config: `vimrc` (loaded automatically or via `VIMINIT` alias in Zsh)

## Features
- Sensible vim defaults: line numbers, 4-space indentation, syntax highlighting
- Persistent undo history stored under `~/.config/vim/undo/`
- Zero external plugin dependencies (pure vimscript)

## Usage
```bash
vim <file>              # launches vim with custom ~/.config/vim/vimrc
```
