# ~/.config/zsh/conf.d/06-plugins.zsh

# Load system-wide Arch Linux Zsh plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# --- Atuin + FZF Integration ---
if command -v atuin >/dev/null 2>&1 && command -v fzf >/dev/null 2>&1; then
  # 1. Stop Atuin from taking over your keybindings
  export ATUIN_NOBIND="true"
  
  # 2. Initialize Atuin so it silently records history in the background
  eval "$(atuin init zsh)"

  # 3. Create a custom widget to use fzf as the frontend
  _fzf_atuin_search() {
    local selected
    
    # How this pipeline works:
    # - `atuin history list --cmd-only`: Dumps your entire Atuin database (oldest to newest)
    # - `tac`: Reverses the list so the newest commands are at the top
    # - `awk '!seen[$0]++'`: Removes duplicate commands, keeping only the most recent execution
    # - `fzf`: Opens the fuzzy finder inline
    selected=$(atuin history list --cmd-only | tac | awk '!seen[$0]++' | \
      fzf --height=15 --layout=reverse --query="$LBUFFER" --prompt="History > ")
    
    # If a command was selected, populate the prompt with it
    if [[ -n "$selected" ]]; then
      BUFFER="$selected"
      CURSOR=$#BUFFER
    fi
    zle reset-prompt
  }
  
  # 4. Bind the new widget to Ctrl+R
  zle -N _fzf_atuin_search
  bindkey '^R' _fzf_atuin_search
fi
