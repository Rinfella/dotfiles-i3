# bat

A `cat` clone with syntax highlighting, Git integration, and Catppuccin theme.

## Prerequisites
- `bat` (managed by mise)
- Config: `config` (symlinked to `~/.config/bat/config`)

## Configuration Details
- **Theme:** Catppuccin Mocha (`BAT_THEME="Catppuccin Mocha"`)
- **Style:** Numbers, changes gutter markers, header filename
- **Paging:** Disabled by default (`--paging=never`) for rapid stdout inspection

## Zsh Aliases & Helpers

| Alias | Command | Purpose |
|---|---|---|
| `cat` | `bat` | Modern highlighted file display |
| `catp` | `bat --plain` | Raw output with no line numbers or box borders |
| `bh` | `bat --paging=always` | Bat with pager enabled for reading long files |
| `batd` | `bat --diff` | View only modified lines according to Git |
| `batl` | `bat --list-languages` | Show all supported file extensions and languages |
| `catn` | `/usr/bin/cat` | Escape hatch to run original coreutils `cat` |
