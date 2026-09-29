# lazygit

Simple terminal UI for Git commands.

## Prerequisites
- `lazygit` (managed by mise)
- Config: `config.yml` (symlinked to `~/.config/lazygit/config.yml`)

## Launching
```bash
lg          # shorthand zsh alias
lazygit     # standard command
```
Inside Neovim: press `<leader>gg` to toggle LazyGit floating window.

## Keybinds Cheatsheet

### Panel Navigation
| Key | Action |
|-----|--------|
| `1` | Files / Staging panel |
| `2` | Branches panel |
| `3` | Commits panel |
| `4` | Stash panel |
| `[` / `]` | Previous / next tab in panel |
| `h / j / k / l` | Move cursor and navigate |

### File Operations (`1`)
| Key | Action |
|-----|--------|
| `Space` | Stage / unstage file |
| `a` | Stage all files |
| `c` | Commit staged changes (opens commit prompt) |
| `C` | Commit with editor |
| `d` | Discard changes in file |
| `i` | Ignore file (`.gitignore`) |

### Branch Operations (`2`)
| Key | Action |
|-----|--------|
| `Space` | Checkout branch |
| `n` | Create new branch |
| `F` | Pull from remote |
| `P` | Push to remote |
| `M` | Merge into current branch |

### Commit Operations (`3`)
| Key | Action |
|-----|--------|
| `s` | Squash into commit below |
| `r` | Reword commit message |
| `d` | Drop commit |
| `t` | Revert commit |

### Universal
| Key | Action |
|-----|--------|
| `?` | Show comprehensive contextual keybindings popup |
| `<Esc>` / `q` | Back / Quit |
