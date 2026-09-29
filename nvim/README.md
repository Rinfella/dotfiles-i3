# nvim

Neovim config using [lazy.nvim](https://github.com/folke/lazy.nvim).

## Prerequisites
- `neovim` >= 0.10 (managed by mise)
- `git`, `ripgrep` (fd, rg for Telescope)
- A Nerd Font (JetBrains Mono Nerd Font recommended)
- Node.js (for LSP servers — managed by mise)
- `obsidian-notes` vault at `~/Documents/obsidian-notes`

## Structure
```
nvim/
├── init.lua              # Entry point, loads lazy.nvim
├── lazy-lock.json        # Plugin lockfile
└── lua/
    ├── config/
    │   ├── keymaps.lua   # All keybindings
    │   ├── options.lua   # Vim options
    │   └── autocmds.lua  # Autocommands + LSP attach
    └── plugins/
        ├── coding.lua    # LSP, completion, formatting, treesitter
        ├── editor.lua    # Telescope, Neo-tree, gitsigns, trouble
        ├── notes.lua     # obsidian.nvim, render-markdown
        ├── ui.lua        # Noice, notify, alpha dashboard, colorscheme
        ├── terminal.lua  # toggleterm
        ├── neoclip.lua   # Clipboard history
        └── 99.lua        # AI agent integration
```

## Keybinds

> Leader = `Space`

### Core
| Key | Action |
|-----|--------|
| `<leader>w` | Save |
| `<leader>q` | Quit |
| `<Esc>` | Clear search highlight |
| `<C-h/j/k/l>` | Navigate splits |

### Explorer (Neo-tree)
| Key | Action |
|-----|--------|
| `<leader>e` | Reveal current file in tree |
| `<leader>o` | Toggle file tree |

### Telescope (Find)
| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Buffers |
| `<leader>fh` | Help tags |

### Git
| Key | Action |
|-----|--------|
| `<leader>gg` | Lazygit (full TUI) |
| `<leader>gb` | Blame current line |

### Diagnostics & Quickfix
| Key | Action |
|-----|--------|
| `[d` / `]d` | Previous / next diagnostic with floating popup |
| `[q` / `]q` | Previous / next quickfix list item |
| `[l` / `]l` | Previous / next location list item |
| `<leader>xx` | Workspace diagnostics (Trouble) |
| `<leader>xX` | Buffer diagnostics (Trouble) |
| `<leader>xs` | Symbols (Trouble) |
| `<leader>xl` | LSP references (Trouble) |
| `<leader>xq` | Quickfix list (Trouble) |
| `<leader>xL` | Location list (Trouble) |
| `gd` | Go to definition |
| `K` | LSP hover documentation |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code actions |

### Notes (Obsidian)
| Key | Action |
|-----|--------|
| `<leader>nn` | New note |
| `<leader>nf` | Find/search notes |
| `<leader>nq` | Quick switch |
| `<leader>ng` | Search by tags |
| `<leader>nd` | Today's daily note |
| `<leader>ny` | Yesterday |
| `<leader>nm` | Tomorrow |
| `<leader>nt` | Insert template |
| `<leader>ni` | New note from template |
| `<leader>ns` | New scratch note |
| `<leader>nb` | Backlinks |
| `<leader>nl` | Outgoing links |
| `<leader>nL` | Link word to new note |
| `<leader>nk` | *(visual)* Link selection |
| `<leader>nx` | *(visual)* Extract → new note |
| `<leader>nr` | Rename note |
| `<leader>nw` | Switch workspace |
| `<CR>` | Toggle checkbox `[ ]→[x]→[-]` |
| `gf` | Follow wikilink under cursor |

### Terminal (ToggleTerm)
| Key | Action |
|-----|--------|
| `<leader>th` | Horizontal terminal |
| `<leader>tf` | Floating terminal |

### Clipboard
| Key | Action |
|-----|--------|
| `<leader>ch` | Clipboard history (Neoclip) |

### AI (99)
| Key | Action |
|-----|--------|
| `<leader>9v` | Visual selection |
| `<leader>9V` | Visual with prompt |
| `<leader>9s` | Stop requests |
| `<leader>9l` | View logs |
| `<leader>9i` | Info |

## Plugin Management
```bash
nvim                    # opens nvim, lazy auto-installs on first run
:Lazy                   # open plugin manager UI
:Lazy update            # update all plugins
:Lazy sync              # install + update + clean
:checkhealth            # diagnose plugin/LSP issues
```

## Obsidian Templates
Located in `~/Documents/obsidian-notes/templates/`:
- `daily_notes.md` — Focus / Log / Notes / Tomorrow sections
- `default_note_template.md` — Minimal general note
- `meeting.md` — Agenda / Notes / Action Items / Decisions
- `project.md` — Goal / Tasks / Links
- `bug.md` — Repro steps / Expected / Actual / Fix
- `inbox.md` — Quick capture with timestamp
