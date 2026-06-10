# zsh config reference

Zsh config lives in `conf.d/`. Files are sourced in numeric order via the main `.zshrc`.

---

## Load Order

| File | Description |
|---|---|
| `00-tmux.zsh` | Auto-start tmux: SSH gets host-named session, local attaches/creates numbered sessions |
| `01-options.zsh` | zsh options (AUTO_CD, CORRECT, history settings) and HISTFILE path |
| `02-keybindings.zsh` | Vi mode, emacs insert-mode lifesavers, magic Ctrl+Z |
| `03-aliases.zsh` | All shell aliases (bat, eza, fd, rg, git, docker, aws, gcp, tmux, etc.) |
| `04-mise-node.zsh` | NVM_DIR kept for compat; note documenting old nvm removal |
| `05-tools.zsh` | gcloud, uv, thefuck (`FUCK` alias), navi widget, zoxide init |
| `06-mise.zsh` | `mise activate`, completions, and `mr`/`mu`/`mi` aliases |
| `10-plugins.zsh` | zsh-autosuggestions, zsh-syntax-highlighting, atuin+fzf Ctrl+R integration |

---

## Keybindings (`02-keybindings.zsh`)

### Mode

- **Vi mode** is active (`bindkey -v`)
- `KEYTIMEOUT=1` — minimal delay when switching modes

### Insert Mode — Emacs Lifesavers

| Binding | Action |
|---|---|
| `Ctrl+A` | Go to beginning of line |
| `Ctrl+E` | Go to end of line |
| `Ctrl+K` | Kill (delete) everything right of cursor |
| `Ctrl+U` | Kill everything left of cursor |
| `Ctrl+W` | Delete word to the left |
| `Alt+D` | Delete word to the right |
| `Alt+Backspace` | Delete word to the left (alternate) |

### Navigation

| Binding | Action |
|---|---|
| `Ctrl+Left` | Jump one word left |
| `Ctrl+Right` | Jump one word right |
| `Home` | Go to beginning of line (terminal fix) |
| `End` | Go to end of line (terminal fix) |
| `Delete` | Forward delete (terminal fix) |

### Completion

| Binding | Action |
|---|---|
| `Shift+Tab` | Cycle backwards through completion menu |

### Magic Ctrl+Z

| Context | Action |
|---|---|
| Empty command line | Run `fg` (resume last suspended job) |
| Non-empty command line | Push current command to background |

---

## Environment Variables (`.zshenv`)

### XDG Base Dirs

| Variable | Purpose |
|---|---|
| `XDG_CONFIG_HOME` | User config (`~/.config`) |
| `XDG_DATA_HOME` | User data (`~/.local/share`) |
| `XDG_STATE_HOME` | User state (`~/.local/state`) |
| `XDG_CACHE_HOME` | User cache (`~/.cache`) |
| `ZDOTDIR` | `$XDG_CONFIG_HOME/zsh` — zsh config dir |

### Display / Terminal

| Variable | Value |
|---|---|
| `TERMINAL` | `xterm-kitty` |

### Development Toolchains

| Variable | Purpose |
|---|---|
| `ANDROID_HOME` | Android SDK root |
| `CARGO_HOME` | Rust cargo home (XDG) |
| `RUSTUP_HOME` | Rustup home (XDG) |
| `GOPATH` | Go workspace |
| `NVM_DIR` | Kept for compatibility (nvm removed, mise manages node) |
| `BUN_INSTALL` | Bun runtime install dir |
| `GRADLE_USER_HOME` | Gradle cache (XDG) |

### Node / npm

| Variable | Purpose |
|---|---|
| `NPM_CONFIG_USERCONFIG` | npm config file (XDG) |
| `NPM_CONFIG_CACHE` | npm cache dir (XDG) |
| `NODE_REPL_HISTORY` | Node REPL history file (XDG) |

### Infrastructure / Cloud

| Variable | Purpose |
|---|---|
| `ANSIBLE_HOME` | Ansible config dir (XDG) |
| `DOCKER_CONFIG` | Docker config dir (XDG) |
| `LOCALSTACK_VOLUME_DIR` | LocalStack volumes |
| `AWS_CONFIG_FILE` | AWS config file (XDG) |
| `AWS_SHARED_CREDENTIALS_FILE` | AWS credentials file (XDG) |
| `DDEV_CONFIG_DIR` | DDEV config (XDG) |

### Shell History / Tools

| Variable | Purpose |
|---|---|
| `ATUIN_CONFIG_DIR` | Atuin config (XDG) |
| `ATUIN_DATA_DIR` | Atuin data (XDG) |
| `LAZYSSH_DATA_DIR` | LazySsh data dir |

### SQL / Database History

| Variable | Purpose |
|---|---|
| `PSQL_HISTFILE` | psql history (XDG) |
| `MYSQL_HISTFILE` | mysql history (XDG) |
| `MARIADB_HISTFILE` | mariadb history (XDG) |

### Python

| Variable | Purpose |
|---|---|
| `PYTHON_HISTORY` | Python REPL history (XDG) |

### Misc XDG Cleanups

| Variable | Purpose |
|---|---|
| `WGETRC` | wget config (XDG) |
| `CURL_HOME` | curl config dir (XDG) |
| `INPUTRC` | readline config (XDG) |
| `LESSHISTFILE` | less history (XDG) |
| `PULSE_COOKIE` | PulseAudio cookie (XDG) |
| `PARALLEL_TMPDIR` | GNU parallel temp dir |
| `YARN_CACHE_FOLDER` | Yarn cache (XDG) |

### bat Theme

| Variable | Value | Notes |
|---|---|---|
| `BAT_THEME` | `Catppuccin Mocha` | Inherited by delta, fzf preview, any tool that calls bat |

---

## Aliases (`03-aliases.zsh`)

### Navigation

| Alias | Expands to |
|---|---|
| `..` | `cd ..` |
| `...` | `cd ../..` |
| `....` | `cd ../../..` |
| `c` | `cd` (with fzf or argument) |
| `path` | Print `$PATH` entries line by line |
| `y` | yazi with cwd-on-quit wrapper |
| `lg` | `lazygit` |
| `vim` | vim with `VIMINIT` set |

### bat (conditional on bat being installed)

| Alias | Expands to | Notes |
|---|---|---|
| `cat` | `bat` | Syntax-highlighted output |
| `catp` | `bat --plain` | No line numbers, no decorations |
| `bh` | `bat --paging=always` | Paged for big files |
| `batd` | `bat --diff` | **Only changed lines** vs git index |
| `batl` | `bat --list-languages` | List supported languages |
| `catn` | `/usr/bin/cat` | Real cat bypass |

> ⚠️ **`batd` / `--diff` gotcha:** `--diff` suppresses ALL output for files that are not tracked by git or have no uncommitted changes. Never add this to `bat/config` globally — use `batd` only explicitly when you want diff view.

### eza (conditional on eza being installed)

| Alias | Expands to |
|---|---|
| `ls` | `eza --icons --group-directories-first` |
| `ll` | `eza -l --icons --group-directories-first` |
| `la` | `eza -la --icons --group-directories-first` |
| `l` | `eza -l --icons --group-directories-first` |
| `tree` | `eza --tree --icons` |

### fd / ripgrep / jq

| Alias | Expands to |
|---|---|
| `find` | `fd` |
| `grep` | `rg` |
| `rg` | `rg --color=always --smart-case` |
| `json` | `jq .` |

### tmux

| Alias | Expands to |
|---|---|
| `tmux` / `t` | `tmux -u` (Unicode support) |
| `ta` | `tmux attach` |
| `tl` | `tmux list-sessions` |
| `tn` | `tmux new-session` |
| `tk` | `tmux kill-session` |

### pacman

| Alias | Expands to |
|---|---|
| `pacup` | `sudo pacman -Syu` |
| `pacin` | `sudo pacman -S` |
| `pacrm` | `sudo pacman -Rns` |
| `pacls` | `pacman -Qs` |

### Laravel / PHP

| Alias | Expands to |
|---|---|
| `art` | `php artisan` |
| `mfs` | `php artisan migrate:fresh --seed` |
| `tink` | `php artisan tinker` |
| `serve` | `php artisan serve` |
| `artopt` | `php artisan optimize` |
| `fil` | `php artisan filament:...` |

### Docker

| Alias | Expands to |
|---|---|
| `d` | `docker` |
| `dc` | `docker compose` |
| `dcu` | `docker compose up -d` |
| `dcd` | `docker compose down` |
| `dps` | `docker ps` (formatted table) |
| `dex` | `docker exec -it` |
| `dlogs` | `docker logs -f` |

### AWS

| Alias | Expands to |
|---|---|
| `awsp` | `export AWS_PROFILE=` |
| `s3ls` | `aws s3 ls` |
| `ec2ls` | `aws ec2 describe-instances` (formatted table) |

### GCP

| Alias | Expands to |
|---|---|
| `gc` | `gcloud` |
| `gcp` | `gcloud compute` |
| `gproj` | `gcloud config set project` |
| `gcssh()` | SSH with `TERM=xterm-256color` |

### Git

| Alias | Expands to |
|---|---|
| `g` | `git` |
| `gs` | `git status` |
| `gd` | `git diff` |
| `gdc` | `git diff --cached` |
| `gl` | `git log --oneline --graph -n10` |
| `gco` | `git checkout` |
| `gcb` | `git checkout -b` |
| `gp` | `git push` |
| `gpl` | `git pull` |
| `gfb()` | fzf branch switcher function |

### delta (conditional on delta being installed)

| Alias | Expands to |
|---|---|
| `diff` | `delta` |

Install: `sudo pacman -S git-delta`

### mise (`06-mise.zsh`)

| Alias | Expands to |
|---|---|
| `mr` | `mise run` |
| `mu` | `mise use` |
| `mi` | `mise install` |

### Audio / EasyEffects

| Alias | Action |
|---|---|
| `ees` | Start easyeffects |
| `eer` | Restart easyeffects |
| `eequit` | Quit easyeffects |
| `eelogs` | Follow easyeffects logs |

---

## Plugins (`10-plugins.zsh`)

### zsh-autosuggestions

Loaded from system packages. Suggests commands as you type based on history.

### zsh-syntax-highlighting

Loaded from system packages. Highlights valid commands green and invalid ones red as you type.

### Atuin + fzf — Ctrl+R History

Atuin is the history **backend** (sync, search, dedup). fzf is the **frontend** (interactive UI).

How it works:

1. `ATUIN_NOBIND=true` — prevents atuin from claiming `Ctrl+R` itself
2. A custom `_fzf_atuin_search` zle widget is defined:
   - Calls `atuin search` to retrieve history
   - Pipes through `awk` to **deduplicate** entries
   - Passes to `fzf` (newest-first ordering)
   - Selected command is inserted into the command line buffer
3. `Ctrl+R` is bound to `_fzf_atuin_search`

**Result:** `Ctrl+R` opens a fast, deduplicated, fuzzy-searchable history sorted newest-first, powered by atuin's database with fzf's UI.

---

## Vi Mode Notes

- Activated with `bindkey -v`
- `KEYTIMEOUT=1` reduces the ESC delay to 10ms (1 × 10ms), making mode switching snappy
- Common emacs bindings are re-bound in **insert mode** so you don't lose muscle memory for `Ctrl+A`, `Ctrl+E`, etc.
- Normal mode uses standard vi navigation (`h`, `j`, `k`, `l`, `w`, `b`, `0`, `$`, etc.)

---

## bat Notes

### Config (`~/.config/bat/config`)

```
--theme="Catppuccin Mocha"
--style="numbers,changes,header-filename"
--paging=never
--wrap=character
```

- `numbers` — line numbers in gutter
- `changes` — git change markers (`+`/`-`/`~`) in gutter
- `header-filename` — file name shown in header
- `--paging=never` — behaves like `cat` by default (use `bh` alias for paging)

### `BAT_THEME` env var

Set in `.zshenv` so it's available to **all tools** that invoke bat internally (delta, fzf preview pane, etc.) — not just interactive `cat`/`bat` calls.

### `--diff` gotcha

`bat --diff` (the `batd` alias) only shows lines that differ from the git index. This means:

- **Untracked files** → no output at all
- **Clean tracked files** (no changes) → no output at all
- **Only files with staged or unstaged changes** → shows those changed lines

This is why `--diff` is **not** in `bat/config`. It would make `cat` silently produce no output on most files. Use `batd` explicitly only when you want this behavior.
