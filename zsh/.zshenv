# XDG Base Directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Define ZDOTDIR to keep $HOME clean
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Global Env Vars
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export TERMINAL="xterm-kitty"

# Android SDK
export ANDROID_HOME=/opt/android-sdk

# GUI Settings
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"

# Composer global
export PATH="$HOME/bin:$HOME/.config/composer/vendor/bin:$PATH"

# Android SDK tools
export PATH="$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin"

# Ansible shared folder
export ANSIBLE_HOME="$XDG_CONFIG_HOME/ansible"

# Atuin & LazySSH
export ATUIN_LOG="error"
export ATUIN_CONFIG_DIR="$XDG_CONFIG_HOME/atuin"
export ATUIN_DATA_DIR="$XDG_DATA_HOME/atuin"
export LAZYSSH_DATA_DIR="$XDG_DATA_HOME/lazyssh"

# AWS CLI 
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME/aws/config"
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME/aws/credentials"

# Containers
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export LOCALSTACK_VOLUME_DIR="$XDG_DATA_HOME/localstack"

# Rust & Go 
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export GOPATH="$XDG_DATA_HOME/go"
export PATH="$GOPATH/bin:$PATH"

# NPM & NVM
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"
export NVM_DIR="$XDG_DATA_HOME/nvm"
export BUN_INSTALL="$XDG_DATA_HOME/bun"

# Java and Android
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export ANDROID_USER_HOME="$XDG_DATA_HOME/android"
export _JAVA_OPTIONS="-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java"

# SQL History Files
export PSQL_HISTFILE="$XDG_DATA_HOME/psql_history"
export MYSQL_HISTFILE="$XDG_DATA_HOME/mysql_history"
export MARIADB_HISTFILE="$XDG_DATA_HOME/mariadb_history"

# Parallel
export PARALLEL_TMPDIR="$XDG_CACHE_HOME/parallel"

# Ddev
export DDEV_CONFIG_DIR="$XDG_CONFIG_HOME/ddev"

# Yarn
export YARN_CACHE_FOLDER="$XDG_CACHE_HOME/yarn"

# Wget & Curl Configs
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
export CURL_HOME="$XDG_CONFIG_HOME"

# Readline Config
export INPUTRC="$XDG_CONFIG_HOME/inputrc"

# Cleaner Home Directory (Evictions)
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export LESSHISTFILE="$XDG_STATE_HOME/less/history"
export PYTHON_HISTORY="$XDG_STATE_HOME/python_history"
export PULSE_COOKIE="$XDG_CONFIG_HOME/pulse/cookie"

# Xsession errors are handled by the display manager (~/.xsession-errors)
# Do NOT redirect stderr here - it will break verbose output in terminal
