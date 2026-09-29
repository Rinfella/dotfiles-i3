# mise — universal tool version manager & dotfiles manager
# https://mise.jdx.dev

if command -v mise >/dev/null 2>&1; then
  # Ensure shims are in PATH (also exported in ~/.zshenv)
  export PATH="$HOME/.local/share/mise/shims:$PATH"

  # Runtime & tool management
  alias mr="mise run"
  alias mu="mise use"
  alias mi="mise install"
  alias mup="mise upgrade"
  alias mls="mise ls"

  # Dotfiles management
  alias mdot="mise dot"
  alias mdota="mise dot apply"
  alias mdots="mise dot status"
  alias mdotd="mise dot diff"
fi
