#!/bin/zsh

git clone --recursive https://github.com/sorin-ionescu/prezto.git "${HOME}/.zprezto"
git clone --recursive https://github.com/printesoi/dotfiles.git "${HOME}/dotfiles"

for rcfile in "${HOME}/dotfiles/"{vimrc,zshrc,zshenv,zpreztorc,gitconfig}; do
    ln -s "$rcfile" "${HOME}/.${rcfile:t}"
done

ln -s "${HOME}/dotfiles/vimfiles" "${HOME}/.vim"
mkdir -p "${HOME}/.vim/tmp"

vim +PluginInstall +qall
