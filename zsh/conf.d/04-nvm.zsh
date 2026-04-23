# Define the NVM directory explicitly
export NVM_DIR="$XDG_DATA_HOME/nvm"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# This loads nvm bash_completion (optional, but highly recommended)
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
