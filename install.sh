#!/bin/bash
# Install my dotfiles and install other needed tools.
SRC_DIR="~/src"
DOTFILES_DIR="${SRC_DIR}/dotfiles"

# TODO: logging
mkdir -p "${SRC_DIR}"
git clone https://github.com/gaylatea/dotfiles.git "${DOTFILES_DIR}"

cd "${DOTFILES_DIR}"

# TODO: homebrew install
# TODO: oh-my-zsh install
# TODO: brew bundle
# TODO: symlink all the files
# TODO: decrypt files with age