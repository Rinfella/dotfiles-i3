# mise — universal tool version manager (replaces nvm + phpv)
# https://mise.jdx.dev

if command -v mise >/dev/null 2>&1; then
  # Use shims for ultra-fast shell startup (0ms vs ~50ms)
  export PATH="$HOME/.local/share/mise/shims:$PATH"

  # mise QOL shortcuts
  alias mr="mise run"
  alias mu="mise use"
  alias mi="mise install"
fi

