#!/bin/zsh

git clone --recursive https://github.com/sorin-ionescu/prezto.git "${HOME}/.zprezto"
git clone --recursive https://github.com/printesoi/dotfiles.git "${HOME}/dotfiles"

for rcfile in "${HOME}/dotfiles/"{{,g}vimrc,zshrc,zshenv,zpreztorc,gitconfig,lesskey}; do
    ln -s "$rcfile" "${HOME}/.${rcfile:t}"
done

lesskey

ln -s "${HOME}/dotfiles/vimfiles" "${HOME}/.vim"
mkdir -p "${HOME}/.vim/tmp"

git clone https://github.com/VundleVim/Vundle.vim.git "${HOME}/.vim/bundle/Vundle.vim"

# This is still interactive
vim +PluginInstall +qall
