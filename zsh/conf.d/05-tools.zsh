# Google Cloud SDK
if [ -f '/opt/google-cloud-sdk/path.zsh.inc' ]; then . '/opt/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/opt/google-cloud-sdk/completion.zsh.inc' ]; then . '/opt/google-cloud-sdk/completion.zsh.inc'; fi

# UV Shell completion
if command -v uv >/dev/null 2>&1; then
  eval "$(uv generate-shell-completion zsh)"
  eval "$(uvx --generate-shell-completion zsh)"
fi

# Thefuck
if command -v thefuck >/dev/null 2>&1; then
  eval $(thefuck --alias)
  eval $(thefuck --alias FUCK)
fi

# Navi Widget
if command -v navi >/dev/null 2>&1; then
  eval "$(navi widget zsh)"
fi

# zoxide — smarter cd
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# direnv — per-project .envrc auto-load/unload on cd
# Usage: echo 'export FOO=bar' > .envrc && direnv allow
if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

# zsh-history-substring-search — Up/Down arrow searches by prefix
# Only bind in insert mode so vi normal mode j/k still work
if [[ -f /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
  bindkey -M viins '^[[A' history-substring-search-up
  bindkey -M viins '^[[B' history-substring-search-down
  HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=#313244,fg=#cdd6f4,bold'
  HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=#f38ba8,fg=#1e1e2e,bold'
fi

# Arch command-not-found hook (via pkgfile)
# e.g., typing 'cowsay' tells you which package to pacman install
if [[ -f /usr/share/doc/pkgfile/command-not-found.zsh ]]; then
  source /usr/share/doc/pkgfile/command-not-found.zsh
fi

