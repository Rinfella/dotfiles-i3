# Tmux auto-start logic
if [[ $- == *i* ]] && [ -z "$TMUX" ] && command -v tmux >/dev/null 2>&1; then
  if [ -n "$SSH_CONNECTION" ]; then
    # On SSH session, use host-based session
    exec tmux -u new-session -A -s "ssh-$(hostname)"
  else
    # Find the most recently active unattached session
    latest_unattached=$(tmux list-sessions -F "#{session_activity} #{session_attached} #{session_name}" 2>/dev/null \
      | sort -r \
      | awk '$2 == "0" {print $3; exit}')

    if [ -n "$latest_unattached" ]; then
      # If the unattached session is the continuum ghost "0", rename it into our sequence
      if [ "$latest_unattached" = "0" ]; then
        i=1
        while tmux has-session -t "session$i" 2>/dev/null; do
          i=$((i+1))
        done
        tmux rename-session -t "0" "session$i"
        latest_unattached="session$i"
      fi
      
      # Attach to the (now correctly named) unattached session
      exec tmux -u attach-session -t "$latest_unattached"
    else
      # All sessions are currently attached. Create a net-new one.
      i=1
      while tmux has-session -t "session$i" 2>/dev/null; do
        i=$((i+1))
      done
      exec tmux -u new-session -s "session$i"
    fi
  fi
fi
