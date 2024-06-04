#!/bin/bash
# Install my dotfiles and install other needed tools.
SRC_DIR="${HOME}/src"
DOTFILES_DIR="${SRC_DIR}/dotfiles"
LOG_COLOR_RED="\033[31m"
LOG_COLOR_GREEN="\033[32m"
LOG_RESET="\033[0m"

# Helpful logging functions.
log() {
    DATE=$(date '+%Y-%m-%d %H:%M:%S')
    echo -e "[${DATE:0:20}] $1"
}

log_error() {
    log "${LOG_COLOR_RED}$1${LOG_RESET}"
}

log_success() {
    log "${LOG_COLOR_GREEN}$1${LOG_RESET}"
}

# safe_link "${PWD}/home/.zshrc" "${HOME}/.zshrc"
safe_link() {
    if [[ -e "$2" ]]; then
        if [[ -L "$2" ]]; then
            rm -f "$2"
        else
            mv "$2" "$2.original"
        fi
    fi

    echo "Linking ${1} -> ${2}"
    ln -s "$1" "$2"
}

if [[ "${PWD}" == "${DOTFILES_DIR}" ]]; then
    log_success "You're working locally; will not clone repo."
else
    log "Checking out dotfiles..."
    mkdir -p "${SRC_DIR}"
    git clone https://github.com/gaylatea/dotfiles.git "${DOTFILES_DIR}"
    cd "${DOTFILES_DIR}"

    # Switch the origin to be non-anonymous.
    git remote rm origin
    git remote add origin git@github.com:gaylatea/dotfiles.git
fi

if [[ ! -x "$(which brew)" ]]; then
    log "Homebrew is needed - installing it now..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    log "oh-my-zsh is needed - installing it now..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

log "Installing system software..."
cd "${DOTFILES_DIR}"
brew bundle

log "Unlocking age key..."
mkdir -p "${PWD}/decrypted"
age --decrypt -o "${PWD}/decrypted/gaylatea.key" "${PWD}/encrypted/gaylatea.key.encrypted"
safe_link "${PWD}/decrypted/gaylatea.key" "${HOME}/gaylatea.key"
log_success "Files in this repo can now be decrypted!"

log "Symlinking config files to this repo..."
safe_link "${PWD}/home/.zshrc" "${HOME}/.zshrc"
safe_link "${PWD}/home/.zshrc.d" "${HOME}/.zshrc.d"

safe_link "${PWD}/home/bin" "${HOME}/bin"

safe_link "${PWD}/home/.gitconfig" "${HOME}/.gitconfig"
safe_link "${PWD}/home/.alacritty.toml" "${HOME}/.alacritty.toml"
safe_link "${PWD}/home/.psqlrc" "${HOME}/.psqlrc"
safe_link "${PWD}/home/.tmux.conf" "${HOME}/.tmux.conf"
safe_link "${PWD}/home/Library/Application Support/Code/User/settings.json" \
          "${HOME}/Library/Application Support/Code/User/settings.json"

log "Decrypting files..."
age --decrypt -i "${HOME}/gaylatea.key" -o "${PWD}/decrypted/.npmrc" "${PWD}/encrypted/.npmrc.encrypted"
safe_link "${PWD}/decrypted/.npmrc" "${HOME}/.npmrc"

log "Applying macOS-specific settings..."
./mac.sh
