export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="nanotech"
ZSH_DOTENV_PROMPT=false

zstyle :omz:plugins:ssh-agent agent-forwarding yes
zstyle :omz:plugins:ssh-agent identities id_ed25519 id_github

plugins=(
  git
  dotenv
  ssh-agent
)

source $ZSH/oh-my-zsh.sh

ZSHRCD="${HOME}/.zshrc.d"
if [[ -d "${ZSHRCD}" ]]; then
    if [[ ! -n "$(find ${ZSHRCD} -maxdepth 0 -empty)" ]]; then
        for file in ${ZSHRCD}/*.zshrc; do
            source "${file}"
        done
    fi
else
    mkdir -p "${ZSHRCD}"
fi
