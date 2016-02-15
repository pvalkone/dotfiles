export TERM="xterm-256color"

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
plugins=(brew brew-cask history-substring-search lein mosh osx sbt scala sudo)
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status time)
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"
DEFAULT_USER=$(whoami)
source $ZSH/oh-my-zsh.sh

[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh

[ -f /opt/boxen/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /opt/boxen/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

autoload -Uz ztodo
chpwd() { ztodo }

export LESS="-r -X"

/usr/bin/which -s brew
if [ $? -eq 0 ]; then
  NVM_PREFIX=$(brew --prefix nvm)
  if [[ -d $NVM_PREFIX ]]; then
    export NVM_DIR=~/.nvm
    source $NVM_PREFIX/nvm.sh
  fi
fi

[ -f $HOME/.zsh-secrets ] && source $HOME/.zsh-secrets
