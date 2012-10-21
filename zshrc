#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
[[ -f "$HOME/.zsh/aliases.zsh" ]] && . "$HOME/.zsh/aliases.zsh"
[[ -f "$HOME/.zsh/functions.zsh" ]] && . "$HOME/.zsh/functions.zsh"

SYNCAD_BIN_PATH="/opt/synapticad-17.02b/bin"
[[ -d "$SYNCAD_BIN_PATH" ]] && export PATH="$SYNCAD_BIN_PATH:$PATH"

