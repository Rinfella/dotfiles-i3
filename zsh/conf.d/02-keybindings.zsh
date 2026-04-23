# Enable Vi mode
bindkey -v

# Remove the ESC delay in Vi mode
export KEYTIMEOUT=1

# ==========================================
# Emacs lifesavers in Vi Insert mode
# ==========================================
bindkey -M viins '^a' beginning-of-line
bindkey -M viins '^e' end-of-line
bindkey -M viins '^k' kill-line
bindkey -M viins '^u' backward-kill-line
bindkey -M viins '^w' backward-kill-word

# ==========================================
# Word Deletion & Movement
# ==========================================
# Alt + d to delete word to the right
bindkey -M viins '^[d' kill-word
# Alt + Backspace to delete word to the left
bindkey -M viins '^[^?' backward-kill-word

# Ctrl + Left/Right arrow
bindkey -M viins '^[[1;5C' forward-word
bindkey -M viins '^[[1;5D' backward-word
# Alt + Left/Right arrow
bindkey -M viins '^[^[[C' forward-word
bindkey -M viins '^[^[[D' backward-word

# ==========================================
# Standard Key Fixes
# ==========================================
# Fix Home/End/Delete keys which often break in Vi mode
bindkey -M viins '^[[H' beginning-of-line
bindkey -M viins '^[[F' end-of-line
bindkey -M viins '^[[3~' delete-char
bindkey -M viins '^[OH' beginning-of-line
bindkey -M viins '^[OF' end-of-line

# Fix backspace behavior after returning from command mode
bindkey -M viins '^?' backward-delete-char

# ==========================================
# Quality of Life Hacks
# ==========================================

# Shift + Tab to go backwards in completion menu
bindkey -M viins '^[[Z' reverse-menu-complete

# Magic Ctrl+Z: 
# Hit Ctrl+Z to background a process (like nvim).
# Hit Ctrl+Z on an empty prompt to instantly bring it back (fg).
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z
