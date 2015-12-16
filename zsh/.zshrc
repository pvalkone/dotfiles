# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install

[ -e /opt/boxen/homebrew/share/zsh-completions ] && fpath=(/opt/boxen/homebrew/share/zsh-completions $fpath)

# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Oh-My-ZSH
plugins=(brew lein osx sudo)
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="agnoster"
DEFAULT_USER=$(whoami)
source $ZSH/oh-my-zsh.sh

[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh

source /opt/boxen/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

autoload -Uz ztodo
chpwd() { ztodo }

export LESS="-r -X"
