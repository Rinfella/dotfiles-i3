# git

Global Git configuration and ignore patterns.

## Files
- `gitignore_global` — Global ignore rules (symlinked via `~/.config/git/gitignore_global` or referenced in `~/.config/gitconfig`)
- `gitconfig` (root of doti3) — Global Git author, delta diff pager, and alias settings

## Global Ignores Included
- OS files: `.DS_Store`, `Thumbs.db`, `desktop.ini`
- Editor artifacts: `.vscode/`, `.idea/`, `*.swp`, `*.swo`, `*~`
- Python cache: `__pycache__/`, `*.pyc`
- Local overrides: `.env.local`, `*.local`
- AI agent transient files
