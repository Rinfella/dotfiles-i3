# Native Zsh behavior and options
setopt AUTO_CD              # cd without typing cd
setopt CORRECT              # Auto correct mistakes
setopt EXTENDED_HISTORY     # Write the history file in the ":start:elapsed;command" format
setopt SHARE_HISTORY        # Share history between all sessions
setopt HIST_IGNORE_DUPS     # Don't record an entry that was just recorded again
setopt HIST_IGNORE_ALL_DUPS # Delete old recorded entry if new entry is a duplicate
setopt HIST_IGNORE_SPACE    # Don't record an entry starting with a space

# History (Kept minimal since Atuin will take over, but good as a fallback)
HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=10000
SAVEHIST=10000
mkdir -p "$(dirname "$HISTFILE")"
