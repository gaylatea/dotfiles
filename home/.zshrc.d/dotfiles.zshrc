#!/bin/zsh
dotsync() {
    cd "${HOME}/src/dotfiles"
    git pull
    ./install.sh
}