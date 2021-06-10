export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="nanotech"

plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

for file in ~/.zshrc.d/*.zshrc; do
    source "$file"
done
