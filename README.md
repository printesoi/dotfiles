These are my personal dotfiles. It's still a WIP.

To install them:

    $ curl -sL https://raw.githubusercontent.com/printesoi/dotfiles/master/setup.sh | zsh -s

By default, the setup script also configures ViM and NeoViM. To disable ViM setup
set the `PRINTESOI_DOTFILES_DISABLE_VIM` variable before running the script.
The disable NeoViM setup, set the `PRINTESOI_DOTFILES_DISABLE_NVIM` variable
before running the script. Something like:

    $ curl -sL https://raw.githubusercontent.com/printesoi/dotfiles/master/setup.sh | \
        PRINTESOI_DOTFILES_DISABLE_VIM=1 PRINTESOI_DOTFILES_DISABLE_NVIM=1 zsh -s
