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
[[ -f "$HOME/.zsh/aliases_priv.zsh" ]] && . "$HOME/.zsh/aliases_priv.zsh"

export EDITOR="vim"
bindkey -v
bindkey "^[." insert-last-word
bindkey -M viins '^r' history-incremental-search-backward
bindkey -M vicmd '^r' history-incremental-search-backward

xset -b

#export LIBVA_DRIVER_NAME=vdpau
#export VDPAU_DRIVER=va_gl

export PATH=$HOME/bin:$HOME/.cabal/bin:$PATH

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
