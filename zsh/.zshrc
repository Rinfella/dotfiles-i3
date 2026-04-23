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

# Initialize Starship prompt (must be at the end)
eval "$(starship init zsh)"
