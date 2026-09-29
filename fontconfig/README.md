# fontconfig

Font rendering, antialiasing, and fallback rules for X11 applications.

## Files
- `fonts.conf` — Enforces sub-pixel RGB antialiasing, slight hinting, and preferred default font family hierarchy (JetBrains Mono Nerd Font for monospace).

## Refreshing Font Cache
```bash
fc-cache -fv            # regenerate font cache
fc-match monospace      # verify monospace resolves to JetBrains Mono Nerd Font
```
