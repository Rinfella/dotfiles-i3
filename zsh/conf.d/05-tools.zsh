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

# zoxide — smarter cd (cached init script for instant startup)
if command -v zoxide >/dev/null 2>&1; then
  _zoxide_cache="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zoxide.zsh"
  if [[ ! -s "$_zoxide_cache" ]]; then
    mkdir -p "${_zoxide_cache:h}"
    zoxide init zsh > "$_zoxide_cache" 2>/dev/null
  fi
  source "$_zoxide_cache"
fi

# direnv — per-project .envrc auto-load/unload on cd (cached hook for instant startup)
if command -v direnv >/dev/null 2>&1; then
  _direnv_cache="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/direnv.zsh"
  if [[ ! -s "$_direnv_cache" ]]; then
    mkdir -p "${_direnv_cache:h}"
    direnv hook zsh > "$_direnv_cache" 2>/dev/null
  fi
  source "$_direnv_cache"
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


