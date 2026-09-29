# tmux

Terminal multiplexer configuration with session persistence and Vim integration.

## Prerequisites
- `tmux` >= 3.2
- `tpm` (Tmux Plugin Manager) at `~/.config/tmux/plugins/tpm`
- `xclip` (for Linux clipboard copy integration)
- Catppuccin / Mocha theme palette

## Keybinds

> Prefix = `Ctrl+Space` (changed from default `Ctrl+b`)

### Panes
| Key | Action |
|-----|--------|
| `Prefix + \|` | Split horizontally (in same working directory) |
| `Prefix + -` | Split vertically (in same working directory) |
| `Prefix + h/j/k/l` | Navigate panes (Vim-style) |
| `Ctrl+h/j/k/l` | Seamless Vim ↔ Tmux pane navigation (via vim-tmux-navigator) |
| `Prefix + H/J/K/L` | Resize pane by 5 cells (repeatable) |
| `Prefix + z` | Toggle pane zoom (fullscreen pane) |
| `Prefix + x` | Close current pane |

### Windows
| Key | Action |
|-----|--------|
| `Prefix + c` | New window (in same working directory) |
| `Ctrl+Shift+h` | Previous window (no prefix needed) |
| `Ctrl+Shift+r` | Next window (no prefix needed) |
| `Prefix + 1..9` | Go to window 1..9 |
| `Prefix + ,` | Rename current window |
| `Prefix + &` | Close current window |

### Sessions & Projects
| Key | Action |
|-----|--------|
| `Prefix + P` | Interactive fuzzy project switcher popup (auto-creates/attaches session to `~/projects` or `~/.config`) |
| `Prefix + F` | `tmux-fzf` plugin launcher menu |
| `Prefix + n` | Create new named session |
| `Prefix + r` | Rename current session |
| `Prefix + s` | Interactive session switcher |
| `Prefix + S` | Save session manually (via `tmux-resurrect`) |
| `Prefix + R` | Restore saved session (via `tmux-resurrect`) |
| `Prefix + X` | Kill current session (with confirmation) |

### Copy Mode (Vi style)
| Key | Action |
|-----|--------|
| `Prefix + [` | Enter copy mode |
| `v` | Begin text selection (in copy mode) |
| `y` | Copy selection to system clipboard via `xclip` |
| `q` | Exit copy mode |

### Config & Plugins
| Key | Action |
|-----|--------|
| `Prefix + O` | Reload `tmux.conf` live |
| `Prefix + I` | Install TPM plugins (`tpm` hotkey) |
| `Prefix + U` | Update all plugins |
| `Prefix + C-u` | Clean removed plugins |

## Auto-Start & Shell Integration
Tmux automatically attaches or creates a session on every interactive Zsh shell launch (configured in `zsh/conf.d/00-tmux.zsh`).
- Bypass auto-tmux: `SSH_TTY` sessions attach to a host-named session; set `NO_TMUX=1` to skip.
