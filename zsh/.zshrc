export TERM="xterm-256color"

HISTSIZE=1000
SAVEHIST=1000
bindkey -e

# Oh-My-ZSH
plugins=(brew brew-cask lein mosh osx sbt scala sudo wd yle-dev zsh-completions zsh-syntax-highlighting history-substring-search)
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

autoload -U compinit && compinit

zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

autoload -Uz ztodo
chpwd() { ztodo }

export LESS="-r -X"

[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh
[ -f $HOME/.zsh-secrets ] && source $HOME/.zsh-secrets
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh

binary_exists() {
  /usr/bin/which -s $1
  echo $?
}

if [ $(binary_exists "brew") -eq 0 ]; then
  NVM_PREFIX=$(brew --prefix nvm)
  if [[ -d $NVM_PREFIX ]]; then
    export NVM_DIR=~/.nvm
    source $NVM_PREFIX/nvm.sh
  fi

  export HOMEBREW_NO_ANALYTICS=1
fi

if [ $(binary_exists "xdg-user-dir") -eq 0 ]; then
  DOWNLOAD_DIR=$(xdg-user-dir DOWNLOAD)
else
  DOWNLOAD_DIR="$HOME/Downloads"
fi

alias yle-dl="yle-dl --destdir \"$DOWNLOAD_DIR/Yle Areena\""
alias g="git"

if [[ $(uname -s) == 'Darwin' ]]; then
  alias verify-permissions="sudo /usr/libexec/repair_packages --verify --standard-pkgs /"
  alias repair-permissions="sudo /usr/libexec/repair_packages --repair --standard-pkgs --volume /"
fi

setopt noclobber
setopt nocheckjobs
setopt interactivecomments

zstyle ':urlglobber' url-other-schema
