# ~/.config/doti3/zsh/conf.d/01-theme.zsh
# Centralized Theme & Palette Tokens (Catppuccin Mocha Baseline)
# Editing tokens here propagates across FZF, Bat, Delta, and CLI tools.

export THEME_FLAVOR="mocha"

# Palette: Catppuccin Mocha
export COLOR_BASE="#1e1e2e"
export COLOR_MANTLE="#181825"
export COLOR_CRUST="#11111b"
export COLOR_SURFACE0="#313244"
export COLOR_SURFACE1="#45475a"
export COLOR_SURFACE2="#585b70"
export COLOR_TEXT="#cdd6f4"
export COLOR_SUBTEXT0="#a6adc8"
export COLOR_BLUE="#89b4fa"
export COLOR_LAVENDER="#b4befe"
export COLOR_SAPPHIRE="#74c7ec"
export COLOR_SKY="#89dceb"
export COLOR_TEAL="#94e2d5"
export COLOR_GREEN="#a6e3a1"
export COLOR_YELLOW="#f9e2af"
export COLOR_PEACH="#fab387"
export COLOR_MAROON="#eba0ac"
export COLOR_RED="#f38ba8"
export COLOR_MAUVE="#cba6f7"
export COLOR_PINK="#f5c2e7"
export COLOR_FLAMINGO="#f2cdcd"
export COLOR_ROSEWATER="#f5e0dc"

# Bat / Delta Shared Theme
export BAT_THEME="Catppuccin Mocha"

# FZF Global Theming & Preview Options
export FZF_DEFAULT_OPTS="\
  --height=45% --layout=reverse --border=rounded \
  --color=bg+:${COLOR_SURFACE0},bg:${COLOR_BASE},spinner:${COLOR_ROSEWATER},hl:${COLOR_RED} \
  --color=fg:${COLOR_TEXT},header:${COLOR_RED},info:${COLOR_MAUVE},pointer:${COLOR_ROSEWATER} \
  --color=marker:${COLOR_LAVENDER},fg+:${COLOR_TEXT},prompt:${COLOR_MAUVE},hl+:${COLOR_RED} \
  --color=selected-bg:${COLOR_SURFACE1} \
  --preview 'if [ -d {} ]; then eza --tree --color=always --icons --level=2 {} 2>/dev/null | head -200; else bat --style=numbers,changes --color=always --line-range :100 {} 2>/dev/null; fi' \
  --preview-window=right:50%:hidden --bind=ctrl-/:toggle-preview"
