# atuin

Magical shell history powered by SQLite and fuzzy search.

## Prerequisites
- `atuin` (managed by mise)
- Config: `config.toml` (symlinked to `~/.config/atuin/config.toml`)

## Key Features Configured
- **Search Mode:** `fuzzy` (matches sub-strings easily)
- **UI Style:** `compact` (15 lines inline height, non-intrusive)
- **Directory Filter:** Pressing `Up` key filters by current directory history first
- **Sync:** Local-only (`auto_sync = false`)

## Shortcuts (in Shell)

| Key | Action |
|-----|--------|
| `Ctrl+R` | Open Atuin fuzzy interactive history search |
| `Up` | Search history scoped to current directory |
| `Ctrl+N` / `Ctrl+P` | Next / previous result in list |
| `Tab` | Put selected command into prompt without executing |
| `Enter` | Execute selected command immediately |
| `Ctrl+C` | Dismiss history search |

## CLI Commands
```bash
atuin search <query>    # search command history from CLI
atuin stats             # display shell usage statistics and top commands
atuin history list      # print raw history list
```
