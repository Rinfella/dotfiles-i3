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
      if [ "$latest_unattached" = "0" ]; then
        session_count=$(tmux list-sessions 2>/dev/null | wc -l)
        i=$((session_count + 1))
        tmux rename-session -t "0" "session$i"
        latest_unattached="session$i"
      fi
      exec tmux -u attach-session -t "$latest_unattached"
    else
      session_count=$(tmux list-sessions 2>/dev/null | wc -l)
      exec tmux -u new-session -s "session$((session_count + 1))"
    fi
  fi
fi
