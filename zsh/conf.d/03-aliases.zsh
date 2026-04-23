# ==========================================
# General Navigation & Core
# ==========================================
alias ll='ls -lha --color=auto'
alias la='ls -A --color=auto'
alias l='ls -lah --color=auto'
alias ls='ls --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias c='clear'
alias y="yazi"
alias lg="lazygit"
alias pv="phpvm"
alias path='echo -e ${PATH//:/\\n}'
alias vim='VIMINIT="source $XDG_CONFIG_HOME/vim/vimrc" vim'

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
