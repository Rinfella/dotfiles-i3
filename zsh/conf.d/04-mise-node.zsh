# Node.js & PHP via mise (replaces nvm + phpv)
# Config: ~/.config/doti3/mise/config.toml → ~/.config/mise/config.toml
#
# - node: core backend (prebuilt binaries)
# - php:  registry backend (vfox-php community binaries)

# Legacy NVM_DIR kept for tools that might reference it
export NVM_DIR="$XDG_DATA_HOME/nvm"

# NOTE: Old nvm install at ~/.local/share/nvm (~3.2GB).
# Once mise is verified working, free space with:
#   rm -rf ~/.local/share/nvm ~/.npm/_npx
