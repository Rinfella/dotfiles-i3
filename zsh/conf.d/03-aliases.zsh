# ==========================================
# General Navigation & Core
# ==========================================
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias c='clear'
# yazi — terminal file manager with cwd-on-quit wrapper
if command -v yazi >/dev/null 2>&1; then
  function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
      builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
  }
else
  alias y="yazi"
fi
alias lg="lazygit"
alias path='echo -e ${PATH//:/\\n}'
alias vim='VIMINIT="source $XDG_CONFIG_HOME/vim/vimrc" vim'

# zoxide — smarter cd (learns frequently visited dirs)
# z <dir>  — jump to frecent match
# zi       — interactive fzf picker
if command -v zoxide >/dev/null 2>&1; then
  alias cd='z'
  alias cdi='zi'
fi

# bat — better cat
if command -v bat >/dev/null 2>&1; then
  alias cat='bat'
  alias catp='bat --plain'           # no decorations, raw content
  alias bh='bat --paging=always'     # bat with pager for big files
  alias batd='bat --diff'            # explicit git-diff view (only changed lines)
  alias batl='bat --list-languages'  # list all supported syntax languages
  alias catn='/usr/bin/cat'          # escape hatch: real cat, bypass bat entirely
fi

# eza — modern ls with icons
if command -v eza >/dev/null 2>&1; then
  alias ls='eza --icons --group-directories-first'
  alias ll='eza -l --icons --group-directories-first'
  alias la='eza -la --icons --group-directories-first'
  alias l='eza -la --icons --group-directories-first'
  alias tree='eza --tree --icons'
fi

# fd — modern find
if command -v fd >/dev/null 2>&1; then
  alias find='fd'
fi

# jq — pretty JSON
alias json='jq .'

# ==========================================
# Tmux
# ==========================================
alias tmux="tmux -u"
alias t='tmux -u'
alias ta='tmux attach'
alias tl='tmux list-sessions'
alias tn='tmux new-session'
alias tk='tmux kill-session'

# ==========================================
# Arch Linux / Pacman
# ==========================================
alias pacup="sudo pacman -Syu"                  # Synchronize and update
alias pacin="sudo pacman -S"                    # Install package
alias pacrm="sudo pacman -Rns"                  # Remove package and its isolated dependencies
alias pacls="pacman -Qe"                        # List installed packages

# ==========================================
# Laravel & PHP
# ==========================================
alias art="php artisan"
alias mfs="php artisan migrate:fresh --seed"    # Nuke and pave database
alias tink="php artisan tinker"
alias serve="php artisan serve"
alias artopt="php artisan optimize:clear"       # Clear all Laravel caches
alias fil="php artisan make:filament-resource"  # Quick Filament resource generation

# ==========================================
# Docker
# ==========================================
alias d="docker"
alias dc="docker compose"
alias dcu="docker compose up -d"
alias dcd="docker compose down"
alias dps="docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'" # Cleaner docker ps
alias dex="docker exec -it"                     # Usage: dex <container_name> bash
alias dlogs="docker logs -f"

# lazydocker — Docker TUI (like lazygit for containers)
if command -v lazydocker >/dev/null 2>&1; then
  alias ldc='lazydocker'
fi

# duf — better df (disk usage overview with pretty output)
if command -v duf >/dev/null 2>&1; then
  alias df='duf'
fi

# ==========================================
# AWS CLI
# ==========================================
alias awsp="export AWS_PROFILE="                # Quick profile switch: awsp prod
alias s3ls="aws s3 ls"
# Lists EC2 instances cleanly with Name, ID, and State
alias ec2ls="aws ec2 describe-instances --query 'Reservations[*].Instances[*].{Name:Tags[?Key==\`Name\`]|[0].Value,ID:InstanceId,State:State.Name}' --output table"

# ==========================================
# Google Cloud (GCP)
# ==========================================
alias gc="gcloud"
alias gcp="gcloud compute instances list"
alias gproj="gcloud config set project"         # Quick project switch
gcssh() {
  TERM=xterm-256color gcloud compute ssh "$@"
}

# ==========================================
# Git (QOL & Interactive)
# ==========================================
alias g="git"
alias gs="git status -sb"
alias gd="git diff"
alias gdc="git diff --cached"
alias gl="git log --oneline --graph --decorate -n 10"
alias gco="git checkout"
alias gcb="git checkout -b"
alias gp="git push"
alias gpl="git pull"

# delta — beautiful diff pager (install: sudo pacman -S git-delta)
if command -v delta >/dev/null 2>&1; then
  alias diff='delta'
fi

# Interactive fuzzy branch switcher (requires fzf)
if command -v fzf >/dev/null 2>&1; then
  gfb() {
    local branches branch
    branches=$(git branch --all | grep -v 'HEAD ->') &&
    branch=$(echo "$branches" | fzf --height=15 --layout=reverse +m --prompt="Switch Branch > ") &&
    git checkout "$(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")"
  }
fi

# ==========================================
# Audio & EasyEffects (Systemd Daemon Control)
# ==========================================
alias ees='systemctl --user status easyeffects'      # Check status
alias eer='systemctl --user restart easyeffects'     # Restart / reload profiles
alias eequit='systemctl --user stop easyeffects'     # Quit / Stop daemon
alias eelogs='journalctl --user -u easyeffects -f'   # View live daemon logs

# ==========================================
# QOL Readers
# ==========================================
# glow — render markdown beautifully in terminal
if command -v glow >/dev/null 2>&1; then
  alias md='glow'
fi

# tldr — practical command cheatsheets (faster than man)
# Usage: tldr <command>   e.g. tldr tar, tldr git push
if command -v tldr >/dev/null 2>&1; then
  alias help='tldr'
fi

