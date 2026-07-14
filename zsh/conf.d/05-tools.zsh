# Google Cloud SDK
if [ -f '/opt/google-cloud-sdk/path.zsh.inc' ]; then . '/opt/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/opt/google-cloud-sdk/completion.zsh.inc' ]; then . '/opt/google-cloud-sdk/completion.zsh.inc'; fi

# UV Shell completions are autoloaded from $ZDOTDIR/completions/

# Thefuck (static functions instead of slow python invocations)
if command -v thefuck >/dev/null 2>&1; then
  fuck () {
      TF_PYTHONIOENCODING=$PYTHONIOENCODING;
      export TF_SHELL=zsh;
      export TF_ALIAS=fuck;
      TF_SHELL_ALIASES=$(alias);
      export TF_SHELL_ALIASES;
      TF_HISTORY="$(fc -ln -10)";
      export TF_HISTORY;
      export PYTHONIOENCODING=utf-8;
      TF_CMD=$(
          thefuck THEFUCK_ARGUMENT_PLACEHOLDER $@
      ) && eval $TF_CMD;
      unset TF_HISTORY;
      export PYTHONIOENCODING=$TF_PYTHONIOENCODING;
      test -n "$TF_CMD" && print -s $TF_CMD
  }
  FUCK () {
      TF_PYTHONIOENCODING=$PYTHONIOENCODING;
      export TF_SHELL=zsh;
      export TF_ALIAS=FUCK;
      TF_SHELL_ALIASES=$(alias);
      export TF_SHELL_ALIASES;
      TF_HISTORY="$(fc -ln -10)";
      export TF_HISTORY;
      export PYTHONIOENCODING=utf-8;
      TF_CMD=$(
          thefuck THEFUCK_ARGUMENT_PLACEHOLDER $@
      ) && eval $TF_CMD;
      unset TF_HISTORY;
      export PYTHONIOENCODING=$TF_PYTHONIOENCODING;
      test -n "$TF_CMD" && print -s $TF_CMD
  }
fi

# Navi Widget (static inline)
if command -v navi >/dev/null 2>&1; then
  _navi_call() {
     local result="$(navi "$@" </dev/tty)"
     printf "%s" "$result"
  }

  _navi_widget() {
     local -r input="${LBUFFER}"
     local -r last_command="$(echo "${input}" | navi fn widget::last_command)"
     local replacement="$last_command"

     if [ -z "$last_command" ]; then
        replacement="$(_navi_call --print)"
     elif [ "$LASTWIDGET" = "_navi_widget" ] && [ "$input" = "$previous_output" ]; then
        replacement="$(_navi_call --print --query "$last_command")"
     else
        replacement="$(_navi_call --print --best-match --query "$last_command")"
     fi

     if [ -n "$replacement" ]; then
        local -r find="${last_command}_NAVIEND"
        previous_output="${input}_NAVIEND"
        previous_output="${previous_output//$find/$replacement}"
     else
        previous_output="$input"
     fi

     zle kill-whole-line
     LBUFFER="${previous_output}"
     region_highlight=("P0 100 bold")
     zle redisplay
  }

  zle -N _navi_widget
  bindkey '^g' _navi_widget
fi

# zoxide — smarter cd
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# direnv — per-project .envrc auto-load/unload on cd (static inline)
if command -v direnv >/dev/null 2>&1; then
  _direnv_hook() {
    trap -- '' SIGINT
    eval "$("/usr/bin/direnv" export zsh)"
    trap - SIGINT
  }
  typeset -ag precmd_functions
  if (( ! ${precmd_functions[(I)_direnv_hook]} )); then
    precmd_functions=(_direnv_hook $precmd_functions)
  fi
  typeset -ag chpwd_functions
  if (( ! ${chpwd_functions[(I)_direnv_hook]} )); then
    chpwd_functions=(_direnv_hook $chpwd_functions)
  fi
fi

# zsh-history-substring-search — Up/Down arrow searches by prefix
# Only bind in insert mode so vi normal mode j/k still work
if [[ -f /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
  bindkey -M viins '^[[A' history-substring-search-up
  bindkey -M viins '^[[B' history-substring-search-down
  HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=#313244,fg=#cdd6f4,bold'
  HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=#f38ba8,fg=#1e1e2e,bold'
fi

# Arch command-not-found hook (via pkgfile)
# e.g., typing 'cowsay' tells you which package to pacman install
if [[ -f /usr/share/doc/pkgfile/command-not-found.zsh ]]; then
  source /usr/share/doc/pkgfile/command-not-found.zsh
fi


