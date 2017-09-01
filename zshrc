#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Custom environment variables that need to be set before loading Prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zsh.local/zshenv.before" ]]; then
    source "${ZDOTDIR:-$HOME}/.zsh.local/zshenv.before"
fi

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

if [[ -s "${HOME}/.zsh/aliases.zsh" ]]; then
    source "${HOME}/.zsh/aliases.zsh"
fi

for local_script in zshenv aliases.zsh; do
    if [[ -s "${HOME}/.zsh.local/${local_script}" ]]; then
        source "${HOME}/.zsh.local/${local_script}"
    fi
done

bindkey -v
bindkey "^[." insert-last-word
bindkey -M viins '^r' history-incremental-search-backward
bindkey -M vicmd '^r' history-incremental-search-backward

if [[ -n "${DISPLAY}" ]] && command -v xset >/dev/null 2>&1 ; then
    xset -b
fi

# Completion for AWS CLI
if [[ -f /usr/bin/aws_zsh_completer.sh ]]; then
    source /usr/bin/aws_zsh_completer.sh
fi
