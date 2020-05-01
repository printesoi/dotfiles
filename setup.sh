#!/bin/zsh

: ${PRINTESOI_DOTFILES_DIR:="${HOME}/dotfiles"}

check_prerequisites() {
    local missing=0
    local prerequisites=(git curl cmake python3)
    if [[ -z "${PRINTESOI_DOTFILES_DISABLE_VIM}" ]]; then
        prerequisites+=vim
    fi
    if [[ -z "${PRINTESOI_DOTFILES_DISABLE_NVIM}" ]]; then
        prerequisites+=nvim
    fi
    for cmd in "${prerequisites[@]}"; do
        if ! hash "$cmd"; then
            echo "Missing $cmd" >&2
            missing=1
        fi
    done
    return $missing
}

check_prerequisites || exit 2

is_git_repo() {
    local dir="$1"
    local is_git=1

    pushd -q "$dir"
    git rev-parse --is-inside-work-tree >/dev/null 2>&1 && is_git=0
    pushd -q

    return $is_git
}

clone_repo() {
    local repo="$1"
    local dir="$2"

    if [[ -d "$dir" ]]; then
        if is_git_repo "$dir"; then
            # TODO: maybe pull?
            return 0
        fi
    fi

    git clone --recursive "$repo" "$dir"
}

clone_repo https://github.com/sorin-ionescu/prezto.git "${HOME}/.zprezto"
clone_repo https://github.com/printesoi/dotfiles.git "${PRINTESOI_DOTFILES_DIR}"

for rcfile in "${PRINTESOI_DOTFILES_DIR}/"{zsh,zshrc,zshenv,zpreztorc,gitconfig,lesskey}; do
    ln -vfs "${rcfile}" "${HOME}/.${rcfile:t}"
done

lesskey

# Vim
if [[ -z "${PRINTESOI_DOTFILES_DISABLE_VIM}" ]]; then
    VIMDIR="${HOME}/.vim"

    mkdir -p "${VIMDIR}/tmp"

    for rcfile in {,g}vimrc; do
        ln -vfs "${PRINTESOI_DOTFILES_DIR}/${rcfile}" "${HOME}/.${rcfile:t}"
    done

    clone_repo https://github.com/VundleVim/Vundle.vim.git "${VIMDIR}/bundle/Vundle.vim"
    clone_repo https://github.com/printesoi/gruvbox.git "${VIMDIR}/bundle/gruvbox"

    # This is still interactive
    vim +PluginInstall +qall

    cd "${VIMDIR}/bundle/YouCompleteMe"
    ./install.py --clang-completer --go-completer
fi


# Neovim
if [[ -z "${PRINTESOI_DOTFILES_DISABLE_NVIM}" ]]; then
    NVIMDIR="${HOME}/.config/nvim"

    mkdir -p "${NVIMDIR}/bundle/"
    for rcfile in init.vim ginit.vim; do
        ln -vfs "${PRINTESOI_DOTFILES_DIR}/nvim/${rcfile}" "${NVIMDIR}/${rcfile}"
    done

    clone_repo https://github.com/VundleVim/Vundle.vim.git "${NVIMDIR}/bundle/Vundle.vim"
    clone_repo https://github.com/printesoi/gruvbox.git "${NVIMDIR}/bundle/gruvbox"

    mkdir -p "${HOME}/.cache/nvim/yankring"

    # This is still interactive
    nvim +PluginInstall +qall

    cd "${NVIMDIR}/bundle/YouCompleteMe"
    ./install.py --clang-completer --go-completer
fi

# Powerline symbols
mkdir -p ~/.local/share/fonts/ ~/.config/fontconfig/conf.d/
curl -sSL \
    https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf \
    -o ~/.local/share/fonts/PowerlineSymbols.otf \
    https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf \
    -o ~/.config/fontconfig/conf.d/10-powerline-symbols.conf
fc-cache -vf ~/.local/share/fonts/
