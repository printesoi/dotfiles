#
# Sets Oh My Zsh options.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Set the path to Oh My Zsh.
export OMZ="$HOME/.oh-my-zsh"

# Set the key mapping style to 'emacs' or 'vi'.
zstyle ':omz:module:editor' keymap 'vi'

# Auto convert .... to ../..
zstyle ':omz:module:editor' dot-expansion 'no'

# Set case-sensitivity for completion, history lookup, etc.
zstyle ':omz:*:*' case-sensitive 'no'

# Color output (auto set to 'no' on dumb terminals).
zstyle ':omz:*:*' color 'yes'

# Auto set the tab and window titles.
zstyle ':omz:module:terminal' auto-title 'yes'

# Set the Zsh modules to load (man zshmodules).
# zstyle ':omz:load' zmodule 'attr' 'stat'

# Set the Zsh functions to load (man zshcontrib).
zstyle ':omz:load' zfunction 'zargs' 'zmv'

# Set the Oh My Zsh modules to load (browse modules).
# The order matters.
zstyle ':omz:load' omodule \
  'environment' \
  'terminal' \
  'editor' \
  'history' \
  'directory' \
  'spectrum' \
  'completion' \
  'utility' \
  'git' \
  'prompt' \
  'pacman'

# Set the prompt theme to load.
# Setting it to 'random' loads a random theme.
# Auto set to 'off' on dumb terminals.
zstyle ':omz:module:prompt' theme 'tzesoi'

# This will make you shout: OH MY ZSHELL!
source "$OMZ/init.zsh"

# Customize to your needs...

autoload zcalc
autoload zargs

AUTO_CD=1

export EDITOR="vim"
bindkey -v
bindkey "^[." insert-last-word
bindkey -M viins '^r' history-incremental-search-backward
bindkey -M vicmd '^r' history-incremental-search-backward

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
[[ -f "$HOME/.zsh/aliases.zsh" ]] && . "$HOME/.zsh/aliases.zsh"
[[ -f "$HOME/.zsh/functions.zsh" ]] && . "$HOME/.zsh/functions.zsh"

setopt INTERACTIVE_COMMENTS
