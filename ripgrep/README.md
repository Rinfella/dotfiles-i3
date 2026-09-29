# ripgrep

Line-oriented search tool combining grep speed with intuitive defaults.

## Prerequisites
- `ripgrep` (`rg`, installed via system pacman)
- Config file: `ripgrep` (referenced globally via `RIPGREP_CONFIG_PATH` in `~/.zshenv`)

## Flags Configured in `ripgrep`
- `--smart-case` (case-insensitive unless query contains uppercase)
- `--hidden` (searches hidden files/directories by default)
- `--glob=!.git/*` (always ignores `.git` directory)
- `--max-columns=150` (truncates long minified lines for clean output)
- `--colors=line:fg:yellow` (custom highlight colors)

## Usage
```bash
rg "search_pattern"           # search current directory recursively
rg -t php "namespace"         # search only PHP files
rg -t lua "keymap"            # search only Lua files
rg --files                    # list all files (like find)
```
