# doti3

Dotfiles for **Arch Linux + i3wm**. Managed with symlinks via `deploy.sh`.

---

## ⚡ TLDR / Quick Reference

```bash
# Clone & deploy
git clone <repo> ~/.config/doti3
cd ~/.config/doti3
./deploy.sh --dry-run        # preview what will be linked
./deploy.sh                  # apply symlinks
./deploy.sh --install-deps   # also install packages
```

| Task | Keybind / Command |
|---|---|
| Display auto-detect | `Mod+Shift+a` |
| Screenshot (full) | `Mod+x` |
| Screenshot (selection) | `Mod+Ctrl+x` |
| Clipboard history | `Mod+c` |
| Fuzzy history search | `Ctrl+R` |
| File manager (cwd) | `y` |
| Git TUI | `lg` |
| Tmux attach/create | auto on shell start |

---

## Setup

| Item | Value |
|---|---|
| Repo | `~/.config/doti3` |
| OS | Arch Linux |
| WM | i3wm |
| Shell | zsh |

### deploy.sh

```bash
./deploy.sh [--dry-run] [--install-deps]
```

- **Symlinks directories** to `~/.config/` (e.g. `i3`, `polybar`, `dunst`, `kitty`, etc.)
- **Symlinks individual files** (`.zshenv`, `starship.toml`, etc.)
- **Symlinks easyeffects** presets to `~/.local/share/easyeffects`

---

## Shell (zsh)

Config lives in `zsh/conf.d/`. Files are sourced in numeric order at shell start.

### conf.d Load Order

| File | What it does |
|---|---|
| `00-tmux.zsh` | Auto-start tmux on every interactive shell |
| `01-options.zsh` | zsh options & history settings |
| `02-keybindings.zsh` | Vi mode + emacs lifesavers + magic Ctrl+Z |
| `03-aliases.zsh` | All shell aliases |
| `04-mise-node.zsh` | NVM_DIR compat shim; old nvm removed |
| `05-tools.zsh` | gcloud, uv, thefuck, navi, zoxide |
| `06-mise.zsh` | mise activate + completions + `mr`/`mu`/`mi` aliases |
| `10-plugins.zsh` | zsh-autosuggestions, zsh-syntax-highlighting, atuin+fzf |

### 00-tmux.zsh — Auto-start tmux

- **SSH sessions**: automatically attaches to (or creates) a session named after the hostname.
- **Local sessions**: attaches to the most recent unattached session. If all sessions are attached, creates new ones named `session1`, `session2`, `session3`, …
- **Continuum ghost session**: the ghost session named `"0"` is auto-renamed on attach.

### 01-options.zsh — Options & History

| Option | Effect |
|---|---|
| `AUTO_CD` | Type a dir name to cd into it |
| `CORRECT` | Suggest corrections for mistyped commands |
| `EXTENDED_HISTORY` | Timestamps in history |
| `SHARE_HISTORY` | Share history across sessions |
| `HIST_IGNORE_DUPS` | Don't record duplicate consecutive entries |
| `HIST_IGNORE_ALL_DUPS` | Remove older duplicate entries |
| `HIST_IGNORE_SPACE` | Don't record commands prefixed with space |

`HISTFILE` is set to `$XDG_STATE_HOME/zsh/history`. Atuin handles real history sync/search.

### 02-keybindings.zsh — Keybindings

| Binding | Action |
|---|---|
| **Mode** | Vi mode (`KEYTIMEOUT=1`) |
| `Ctrl+A` | Go to beginning of line (insert mode) |
| `Ctrl+E` | Go to end of line (insert mode) |
| `Ctrl+K` | Kill line right of cursor (insert mode) |
| `Ctrl+U` | Kill line left of cursor (insert mode) |
| `Ctrl+W` | Delete word left (insert mode) |
| `Alt+D` | Delete word right |
| `Alt+Backspace` | Delete word left |
| `Ctrl+Left` | Jump word left |
| `Ctrl+Right` | Jump word right |
| `Home` / `End` / `Delete` | Fixed for terminals that send escape sequences |
| `Shift+Tab` | Backwards completion |
| `Ctrl+Z` | **Magic**: on empty line → `fg`; otherwise → push to background |

### 05-tools.zsh — External Tools Init

- **gcloud** SDK init
- **uv** (Python packaging)
- **thefuck** — corrects last command; also available as `FUCK` alias
- **navi** — interactive cheatsheet widget
- **zoxide** — smarter `cd` replacement

### 10-plugins.zsh — Plugins

- `zsh-autosuggestions` and `zsh-syntax-highlighting` loaded from system packages
- **Atuin + fzf history integration:**
  - `ATUIN_NOBIND=true` (atuin doesn't bind Ctrl+R itself)
  - Custom `_fzf_atuin_search` widget wires Ctrl+R → fzf as the fuzzy frontend over atuin history
  - History is **deduplicated** via `awk` and shown **newest-first**

---

## Environment (.zshenv)

### XDG Directories

Standard XDG base dirs are set. `ZDOTDIR=$XDG_CONFIG_HOME/zsh`.

### Key Variables

| Variable | Value / Purpose |
|---|---|
| `BAT_THEME` | `"Catppuccin Mocha"` — inherited by delta, fzf preview, etc. |
| `TERMINAL` | `xterm-kitty` |
| `ANDROID_HOME` | Android SDK |
| `CARGO_HOME` / `RUSTUP_HOME` | Rust toolchain |
| `GOPATH` | Go workspace |
| `NVM_DIR` | Kept for compat (nvm itself removed, managed by mise) |
| `BUN_INSTALL` | Bun runtime |
| `GRADLE_USER_HOME` | Gradle cache |
| `NPM_CONFIG_USERCONFIG` / `NPM_CONFIG_CACHE` | npm XDG paths |
| `ANSIBLE_HOME` | Ansible |
| `DOCKER_CONFIG` | Docker config XDG path |
| `LOCALSTACK_VOLUME_DIR` | LocalStack |
| `AWS_CONFIG_FILE` / `AWS_SHARED_CREDENTIALS_FILE` | AWS config paths |
| `ATUIN_CONFIG_DIR` / `ATUIN_DATA_DIR` | Atuin XDG paths |
| `LAZYSSH_DATA_DIR` | LazySsh data |
| `PARALLEL_TMPDIR` | GNU parallel temp dir |
| `DDEV_CONFIG_DIR` | DDEV config XDG path |
| `YARN_CACHE_FOLDER` | Yarn cache XDG path |
| `WGETRC` / `CURL_HOME` | wget/curl config XDG paths |
| `INPUTRC` | readline config XDG path |
| `LESSHISTFILE` | less history XDG path |
| `PYTHON_HISTORY` | Python REPL history XDG path |
| `NODE_REPL_HISTORY` | Node REPL history XDG path |
| `PULSE_COOKIE` | PulseAudio cookie XDG path |
| `PSQL_HISTFILE` / `MYSQL_HISTFILE` / `MARIADB_HISTFILE` | SQL history XDG paths |

---

## Aliases

### Navigation

| Alias | Command |
|---|---|
| `..` | `cd ..` |
| `...` | `cd ../..` |
| `....` | `cd ../../..` |
| `c` | `cd` with fzf or argument |
| `path` | Print `$PATH` line by line |
| `y` | yazi wrapper — cwd-on-quit (cd to dir yazi exits in) |
| `lg` | `lazygit` |
| `vim` | vim with `VIMINIT` set |

### bat (if installed)

| Alias | Command |
|---|---|
| `cat` | `bat` |
| `catp` | `bat --plain` (no decorations) |
| `bh` | `bat --paging=always` (paged for big files) |
| `batd` | `bat --diff` (git-diff view, only changed lines vs git index) |
| `batl` | `bat --list-languages` |
| `catn` | `/usr/bin/cat` (real cat bypass) |

> **Note:** `--diff` is an **explicit alias only** — it is NOT in `bat/config` globally because it suppresses all output on untracked/clean files. Use `batd` only when you want diff view.

### eza (if installed)

| Alias | Command |
|---|---|
| `ls` | `eza --icons --group-directories-first` |
| `ll` | `eza -l --icons --group-directories-first` |
| `la` | `eza -la --icons --group-directories-first` |
| `l` | `eza -l --icons --group-directories-first` |
| `tree` | `eza --tree --icons` |

### fd / ripgrep / jq

| Alias | Command |
|---|---|
| `find` | `fd` |
| `grep` | `rg` |
| `rg` | `rg --color=always --smart-case` |
| `json` | `jq .` |

### tmux

| Alias | Command |
|---|---|
| `tmux` / `t` | `tmux -u` |
| `ta` | `tmux attach` |
| `tl` | `tmux list-sessions` |
| `tn` | `tmux new-session` |
| `tk` | `tmux kill-session` |

### pacman

| Alias | Command |
|---|---|
| `pacup` | `sudo pacman -Syu` |
| `pacin` | `sudo pacman -S` |
| `pacrm` | `sudo pacman -Rns` |
| `pacls` | `pacman -Qs` |

### Laravel / PHP

| Alias | Command |
|---|---|
| `art` | `php artisan` |
| `mfs` | `php artisan migrate:fresh --seed` |
| `tink` | `php artisan tinker` |
| `serve` | `php artisan serve` |
| `artopt` | `php artisan optimize` |
| `fil` | `php artisan filament:...` |

### Docker

| Alias | Command |
|---|---|
| `d` | `docker` |
| `dc` | `docker compose` |
| `dcu` | `docker compose up -d` |
| `dcd` | `docker compose down` |
| `dps` | `docker ps` (formatted table) |
| `dex` | `docker exec -it` |
| `dlogs` | `docker logs -f` |

### AWS

| Alias | Command |
|---|---|
| `awsp` | `export AWS_PROFILE=` |
| `s3ls` | `aws s3 ls` |
| `ec2ls` | `aws ec2 describe-instances` (formatted table query) |

### GCP

| Alias | Command |
|---|---|
| `gc` | `gcloud` |
| `gcp` | `gcloud compute` |
| `gproj` | `gcloud config set project` |
| `gcssh()` | SSH with `TERM=xterm-256color` |

### Git

| Alias | Command |
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
| `gfb()` | fzf branch switcher |

### delta (if installed)

| Alias | Command |
|---|---|
| `diff` | `delta` |

> Install: `sudo pacman -S git-delta`

### mise

| Alias | Command |
|---|---|
| `mr` | `mise run` |
| `mu` | `mise use` |
| `mi` | `mise install` |

### Audio / EasyEffects

| Alias | Command |
|---|---|
| `ees` | Start easyeffects |
| `eer` | Restart easyeffects |
| `eequit` | Quit easyeffects |
| `eelogs` | Follow easyeffects logs |

---

## Runtime Management (mise)

| Runtime | Version | Backend |
|---|---|---|
| Node.js | 24 LTS | core (prebuilt) |
| PHP | 8.5 | vfox-php (community) |

```bash
mise use -g node@<version>
mise use -g php@<version>
```

---

## bat Configuration (`~/.config/bat/config`)

| Setting | Value | Notes |
|---|---|---|
| `--theme` | `Catppuccin Mocha` | Also set via `BAT_THEME` env |
| `--style` | `numbers,changes,header-filename` | Git change markers in gutter |
| `--paging` | `never` | Cat-like by default |
| `--wrap` | `character` | Wrap long lines |

> ⚠️ **Do NOT add `--diff` to bat/config globally.** It suppresses all output for files not tracked by git or with no uncommitted changes. Use the `batd` alias explicitly when you want diff view.

---

## Display (i3)

| Binding | Action |
|---|---|
| `Mod+Shift+a` | Auto-detect displays |
| `Mod+Shift+s` | Single display mode |
| `Mod+Shift+p` | Choose layout (rofi menu) |
| `Mod+m` | Mirror displays |

---

## Screenshots

| Binding | Action |
|---|---|
| `Mod+x` | Full screen → save to file |
| `Mod+Shift+x` | Active window → save to file |
| `Mod+Ctrl+x` | Selection → save to file |
| `Mod+Ctrl+c` | Full screen → clipboard |
| `Mod+Ctrl+Shift+c` | Selection → clipboard |

---

## Clipboard (clipmenu + rofi)

| Binding | Action |
|---|---|
| `Mod+c` | Open clipboard history (rofi) |

- `clipmenud` runs as a **systemd user service**
- **Polybar icon**: left-click = history, right-click = pause 5s (for sensitive data)

---

## Notifications (dunst)

| Binding | Action |
|---|---|
| `Mod+d` | Open context menu for notification |
| `Mod+Shift+d` | Close notification |
| `Mod+Ctrl+d` | Close all notifications |
| `Mod+Shift+z` | Pop notification from history |

---

## Tools Overview

| Tool | Role | Config location |
|---|---|---|
| bat | `cat` replacement, syntax highlight, Catppuccin Mocha | `bat/config` |
| eza | `ls` replacement, icons, git status | alias only |
| fd | `find` replacement | alias only |
| ripgrep | `grep` replacement, smart-case, always color | alias only |
| fzf | Fuzzy finder, Ctrl+R history frontend | alias + plugin |
| zoxide | Smarter `cd` | `05-tools.zsh` |
| atuin | Shell history sync + search backend | `10-plugins.zsh` |
| starship | Prompt | `starship.toml` |
| yazi | Terminal file manager, cwd-on-quit | `03-aliases.zsh` |
| lazygit | Git TUI | alias (`lg`) |
| thefuck | Command correction (also `FUCK` alias) | `05-tools.zsh` |
| navi | Interactive cheatsheet widget | `05-tools.zsh` |
| tmux | Multiplexer, auto-start, continuum | `00-tmux.zsh` |
| mise | Runtime versions (node, php) | `mise/config.toml` |
| delta | Diff pager (install: `sudo pacman -S git-delta`) | alias only |