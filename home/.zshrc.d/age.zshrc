#!/bin/zsh
# Easy encryption and decryption to my Age key.
encrypt() {
    cat | age --encrypt -i "$HOME/gaylatea.key" -a
}

decrypt() {
    cat | age --decrypt -i "$HOME/gaylatea.key"
}