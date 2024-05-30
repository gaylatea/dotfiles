#!/bin/bash
# Install my dotfiles and install other needed tools.
SRC_DIR="${HOME}/src"
DOTFILES_DIR="${SRC_DIR}/dotfiles"

# TODO: logging
mkdir -p "${SRC_DIR}"
git clone https://github.com/gaylatea/dotfiles.git "${DOTFILES_DIR}"

cd "${DOTFILES_DIR}"

if [[ ! -x "$(which brew)" ]]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

brew bundle

# TODO: symlink all the files
# TODO: decrypt files with age