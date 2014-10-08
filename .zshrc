export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="terminalparty"

source $ZSH/oh-my-zsh.sh
source /opt/boxen/env.sh
workon adroll

alias util="ssh ari@utility1.adroll.com"
alias db-test-prepare='echo "drop database muscovado_test; create database muscovado_test;" | db && paster setup-app test.ini'

export GOPATH=~
