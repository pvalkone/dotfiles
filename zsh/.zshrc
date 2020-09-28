HISTFILE="${HOME}/.zsh_history"
HISTSIZE=1000
SAVEHIST=${HISTSIZE}
bindkey -e

binary_exists() {
  /usr/bin/which -s $1
  echo $?
}

autoload -Uz compinit && compinit

eval "$(starship init zsh)"

source "${HOME}/.zgen/zgen.zsh"

if ! zgen saved; then
  zgen load zsh-users/zsh-completions src
  zgen load /usr/local/share/zsh/site-functions

  zgen load zdharma/fast-syntax-highlighting
  zgen load zsh-users/zsh-history-substring-search

  zmodload zsh/terminfo
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down

  zgen load chrissicool/zsh-256color
  zgen load junegunn/fzf shell/completion.zsh
  zgen load junegunn/fzf shell/key-bindings.zsh
  zgen load ajeetdsouza/zoxide
  zgen load zsh-users/zsh-autosuggestions

  zgen load unixorn/autoupdate-zgen

  zgen save
fi

export LESS="-r -X"
export GOPATH="${HOME}/.go"
export EDITOR="$(which vim)"
export RUST_BACKTRACE=1
export PYENV_ROOT="${HOME}/.pyenv"
export STEPPATH="${HOME}/.step"
export DOCKER_HOST="tcp://192.168.8.2:2376"
export RIPGREP_CONFIG_PATH="${HOME}/.ripgreprc"

[[ -s "${HOME}/.rvm/scripts/rvm" ]] && source "${HOME}/.rvm/scripts/rvm"

path+=(
  "${HOME}/bin"
  "${HOME}/.cargo/bin"
  "${GOPATH}/bin"
  "${HOME}/.jenv/bin"
  "${HOME}/.scalaenv/bin"
  "${PYENV_ROOT}/bin"
  '/opt/bin'
)

bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

[ -f "${HOME}/.zsh-secrets" ] && source "${HOME}/.zsh-secrets"

if [ $(binary_exists "jenv") -eq 0 ]; then
  eval "$(jenv init -)"
fi

if [ $(binary_exists "scalaenv") -eq 0 ]; then
  eval "$(scalaenv init -)"
fi

if [ $(binary_exists "pyenv") -eq 0 ]; then
  eval "$(pyenv init -)"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

alias g="git"

if test -z "${XDG_RUNTIME_DIR}"; then
    export XDG_RUNTIME_DIR=/tmp/${UID}-runtime-dir
    if ! test -d "${XDG_RUNTIME_DIR}"; then
        mkdir "${XDG_RUNTIME_DIR}"
        chmod 0700 "${XDG_RUNTIME_DIR}"
    fi
fi

export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
eval "$(keychain --eval --agents gpg --quiet)"
gpg-connect-agent updatestartuptty /bye &> /dev/null
