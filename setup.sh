#!/bin/zsh

git clone --recursive https://github.com/sorin-ionescu/prezto.git "${HOME}/.zprezto"
git clone --recursive https://github.com/printesoi/dotfiles.git "${HOME}/dotfiles"

for rcfile in "${HOME}/dotfiles/"{zshrc,zshenv,zpreztorc,gitconfig,lesskey}; do
    ln -s "${rcfile}" "${HOME}/.${rcfile:t}"
done

lesskey

# Vim
if [[ -z "${PRINTESOI_DOTFILES_DISABLE_VIM}" ]]; then
    VIMDIR="${HOME}/.vim"

    ln -s "${HOME}/dotfiles/vimfiles" "${VIMDIR}"
    mkdir -p "${VIMDIR}/tmp"

    for rcfile in {,g}vimrc; do
        ln -s "${HOME}/dotfiles/${rcfile}" "${HOME}/.${rcfile:t}"
    done

    git clone https://github.com/VundleVim/Vundle.vim.git "${VIMDIR}/bundle/Vundle.vim"
    git clone https://github.com/printesoi/gruvbox.git "${VIMDIR}/bundle/gruvbox"

    # This is still interactive
    vim +PluginInstall +qall

    cd "${VIMDIR}/bundle/YouCompleteMe"
    ./install.py --clang-completer
fi


# Neovim
if [[ -z "${PRINTESOI_DOTFILES_DISABLE_NVIM}" ]]; then
    NVIMDIR="${HOME}/.config/nvim"

    mkdir -p "${NVIMDIR}/bundle/"
    for rcfile in init.vim ginit.vim; do
        ln -s "${HOME}/dotfiles/nvim/${rcfile}" "${NVIMDIR}/${rcfile}"
    done

    git clone https://github.com/VundleVim/Vundle.vim.git "${NVIMDIR}/bundle/Vundle.vim"
    git clone https://github.com/printesoi/gruvbox.git "${NVIMDIR}/bundle/gruvbox"

    # This is still interactive
    nvim +PluginInstall +qall

    cd "${NVIMDIR}/bundle/YouCompleteMe"
    ./install.py --clang-completer
fi
