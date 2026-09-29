# Prepend custom completions directory to fpath for fast autoloaded completion
fpath=("$ZDOTDIR/completions" $fpath)

# Preferred editor
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Load all configuration files from conf.d in alphanumeric order
for config_file in "$ZDOTDIR/conf.d/"*.zsh; do
  source "$config_file"
done

# Initialize Starship prompt (cached init script for instant startup)
if command -v starship >/dev/null 2>&1; then
  _starship_cache="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/starship.zsh"
  if [[ ! -s "$_starship_cache" ]]; then
    mkdir -p "${_starship_cache:h}"
    starship init zsh > "$_starship_cache" 2>/dev/null
  fi
  source "$_starship_cache"
fi

