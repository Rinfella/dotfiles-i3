# mise — universal tool version manager (replaces nvm + phpv)
# https://mise.jdx.dev

if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"

  # mise completions
  if [[ -f /usr/share/zsh/site-functions/_mise ]] || command -v mise >/dev/null 2>&1; then
    eval "$(mise completion zsh)" 2>/dev/null || true
  fi
fi
