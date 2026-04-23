# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export ZDOTDIR="$HOME/.config/zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

HYPHEN_INSENSITIVE="true"

zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' frequency 13

DISABLE_AUTO_TITLE="true"

#### PLUGINS
plugins=(git zsh-autosuggestions laravel zsh-syntax-highlighting zsh-fzf-history-search)

source $ZSH/oh-my-zsh.sh

# export MANPATH="/usr/local/man:$MANPATH"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ALIASES
alias ks="TERM=xterm-256color kitten ssh"
alias kssh="TERM=xterm-256color kitten ssh"
alias y="yazi"
alias lg="lazygit"
alias pv="phpvm"
alias tmux="tmux -u"

# Tmux aliases with Nerd Font icons
alias t='tmux -u'
alias ta='tmux attach'
alias tl='tmux list-sessions'  
alias tn='tmux new-session'
alias tk='tmux kill-session'

# Navi Widget
eval "$(navi widget zsh)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/google-cloud-sdk/path.zsh.inc' ]; then . '/opt/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/opt/google-cloud-sdk/completion.zsh.inc' ]; then . '/opt/google-cloud-sdk/completion.zsh.inc'; fi

# Gcloud SSH wrapper:
function gcssh() {
  TERM=xterm-256color gcloud compute ssh "$@"
}

# Only start tmux if:
# - Running interactively
# - Not already inside tmux
# - Terminal supports it

if [[ $- == *i* ]] && [ -z "$TMUX" ] && command -v tmux >/dev/null 2>&1; then
  # On SSH session? Use session named after host or default
  session_name=${TMUX_SESSION:-default}
  if [ -n "$SSH_CONNECTION" ]; then
    session_name="ssh-$(hostname)"
  fi
  # Attach existing or create new session
  exec tmux -u new-session -A -s "$session_name"
fi

# UV Shell completion
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"

# THEFUCK
eval $(thefuck --alias)
eval $(thefuck --alias FUCK)

# Android SDK Barebone stuffs
export ANDROID_HOME=/opt/android-sdk
export PATH=$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin

# PPHV
export PATH="$HOME/bin:$PATH"

# Adding binaries globally installed by composer to path.
export PATH="$PATH:$HOME/.config/composer/vendor/bin"
