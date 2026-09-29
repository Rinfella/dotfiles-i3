# yazi

Blazing fast terminal file manager written in Rust.

## Prerequisites
- `yazi` (managed by mise)
- `ffmpegthumbnailer`, `7zip`, `jq`, `fd`, `ripgrep`, `fzf`

## Shell Wrapper (`y`)
Configured in `zsh/conf.d/03-aliases.zsh`:
```bash
y           # opens yazi, and changes shell CWD to match on quit
```
Press `q` to quit and **stay in the directory** you navigated to.
Press `Q` to quit without changing directory.

## Keybinds

### Navigation
| Key | Action |
|-----|--------|
| `h / j / k / l` | Parent dir / Down / Up / Enter dir |
| `H / L` | History back / History forward |
| `J / K` | Jump 5 items down / up |
| `Ctrl+u / Ctrl+d` | Half page up / down |
| `g g / G` | Go to top / bottom |
| `~` | Go to home directory |

### Selection & Operations
| Key | Action |
|-----|--------|
| `Space` | Toggle select file |
| `v` | Enter visual selection mode |
| `y` | Copy (yank) selected files |
| `x` | Cut selected files |
| `p` | Paste files |
| `d` | Move to trash |
| `D` | Permanent delete |
| `a` | Create new file (append `/` for directory) |
| `r` | Rename |
| `.` | Toggle hidden files |

### Search & Filter
| Key | Action |
|-----|--------|
| `/` | Filter files in current directory |
| `f` | Jump to file using fzf |
| `z` | Jump directory via zoxide |
| `Z` | Interactive zoxide jump |

### Tabs & View
| Key | Action |
|-----|--------|
| `t` | New tab |
| `1..9` | Switch to tab 1..9 |
| `w` | Close tab |
| `Tab` | Switch between active tabs |
| `i` | Image/file preview |
