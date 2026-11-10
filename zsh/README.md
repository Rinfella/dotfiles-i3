# zsh

Zsh shell configuration structured modularly under `conf.d/`.

## Prerequisites
- `zsh`, `starship` (prompt), `atuin` (shell history), `zoxide` (smart cd)
- `bat` (cat replacement), `eza` (ls replacement), `navi` (cheatsheet widget)
- `fzf` (fuzzy search), `mise` (runtime version manager)

## Load Order (`conf.d/`)
Files are sourced in numerical order at interactive shell startup:

| File | Purpose |
|------|---------|
| `00-mise.zsh` | Mise shims in PATH + runtime & dotfile aliases (`mr`, `mdot`, etc.) |
| `00-tmux.zsh` | Auto-attach or create tmux session |
| `01-theme.zsh` | Centralized Catppuccin Mocha palette, FZF_DEFAULT_OPTS, and BAT_THEME |
| `01-options.zsh` | History sharing, auto-cd, correction |
| `02-keybindings.zsh` | Vi-mode keys, magic Ctrl+Z, Ctrl+Y Yazi CWD widget |
| `03-aliases.zsh` | Core aliases (git, docker, arch, php, etc.) |
| `04-mise-node.zsh` | Node / npm environment compatibility |
| `05-tools.zsh` | `navi` widget (`Ctrl+G`), dynamic `direnv` hook, `thefuck` |
| `07-worktrees.zsh` | Git worktree helpers for AI agents & parallel branch development (`gwa`, `gws`, `gwr`, `gwm`) |
| `10-plugins.zsh` | Autosuggestions, syntax highlighting, atuin integration |

## Key Shell Shortcuts

| Key | Action |
|-----|--------|
| `Ctrl+R` | Atuin fuzzy history search (or fallback fzf) |
| `Ctrl+G` | Interactive `navi` command cheat sheet widget |
| `Ctrl+Y` | Interactive `yazi` file manager popup (changes directory on exit with `q`) |
| `Ctrl+Z` | Magic toggle: background current app / resume it immediately |
| `Up / Down` | History substring search (types prefix, filters matching commands) |
| `Alt+.` | Insert last argument from previous command |

## Essential Aliases

### Navigation & Files
```bash
cd <path>        # auto-routed through zoxide (learns frecent paths)
cdi              # interactive fzf directory picker
y                # yazi file manager (changes directory on exit)
ls / ll / la / l # eza with icons & git status
tree             # directory tree via eza
cat / catp / bh  # bat (syntax highlighted) / plain / pager
find             # fd
json             # jq .
```

### Git
```bash
g                # git
gs               # git status -sb
gd / gdc         # git diff / git diff --cached (uses delta)
gl               # compact decorated git log graph
lg               # lazygit TUI
gfb              # interactive fuzzy branch switcher (fzf)
```

### Development & Mise
```bash
mr / mu / mi     # mise run / mise use / mise install
mup / mls        # mise upgrade / mise ls
mdot / mdota     # mise dot / mise dot apply
mdots / mdotd    # mise dot status / mise dot diff
d / dc / dcu     # docker / compose / compose up -d
ldc              # lazydocker TUI
art / tink       # php artisan / php artisan tinker
```
