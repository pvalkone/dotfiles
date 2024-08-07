setopt HIST_IGNORE_SPACE

HISTFILE="${HOME}/.zsh_history"
HISTSIZE=1000
SAVEHIST=${HISTSIZE}
HISTORY_IGNORE="(ls|cd|pwd|exit|cd)*"
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
  zgen load "$(brew --prefix)/share/zsh/site-functions"

  zgen load zdharma-continuum/fast-syntax-highlighting
  zgen load zsh-users/zsh-history-substring-search

  zmodload zsh/terminfo

  zgen load chrissicool/zsh-256color
  zgen load ajeetdsouza/zoxide . main
  zgen load zsh-users/zsh-autosuggestions

  zgen load unixorn/autoupdate-zgen

  zgen save
fi

export LESS="-r -X -S"
export GOPATH="${HOME}/.go"
export EDITOR="$(which vim)"
export RUST_BACKTRACE=1
export PYENV_ROOT="${HOME}/.pyenv"
export STEPPATH="${HOME}/.step"
export DOCKER_HOST="unix://${HOME}/.colima/docker.sock"
export RIPGREP_CONFIG_PATH="${HOME}/.ripgreprc"
export SSH_AUTH_SOCK="${HOME}/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh"
export AWS_VAULT_BACKEND="keychain"
export HOMEBREW_NO_ENV_HINTS=1

[[ -s "${HOME}/.rvm/scripts/rvm" ]] && source "${HOME}/.rvm/scripts/rvm"

path+=(
  "${HOME}/bin"
  "${HOME}/.cargo/bin"
  "${GOPATH}/bin"
  "${HOME}/.jenv/bin"
  "${HOME}/.scalaenv/bin"
  "${PYENV_ROOT}/bin"
  '/opt/bin'
  "$(brew --prefix libpq)/bin"
)

#bindkey '^[[1;5D' backward-word
#bindkey '^[[1;5C' forward-word

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

if [ $(binary_exists "pyenv-virtualenv-init") -eq 0 ]; then
  eval "$(pyenv virtualenv-init -)"
fi

export NVM_DIR="$(brew --prefix nvm)"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

alias b="brew"
alias g="git"
alias k="kubectl"
alias lens-dev="aws-vault exec --duration=1h dvv-viestit-dev -- /Applications/OpenLens.app/Contents/MacOS/OpenLens"
alias vim="nvim"
alias k9s-dvv-viestit-dev="aws-vault exec dvv-viestit-dev -- k9s --kubeconfig ~/.kube/config-dvv-viestit-dev --namespace viestit"
alias k9s-dvv-viestit-qa="aws-vault exec dvv-viestit-qa -- k9s --kubeconfig ~/.kube/config-dvv-viestit-qa --namespace viestit"
alias k9s-dvv-viestit-prod="aws-vault exec dvv-viestit-prod -- k9s --kubeconfig ~/.kube/config-dvv-viestit-prod --namespace viestit"

function kubectl-dvv-viestit-dev() { aws-vault exec dvv-viestit-dev -- kubectl --kubeconfig ~/.kube/config-dvv-viestit-dev --namespace viestit "$@"; }
function kubectl-dvv-viestit-qa() { aws-vault exec dvv-viestit-qa -- kubectl --kubeconfig ~/.kube/config-dvv-viestit-qa --namespace viestit "$@"; }
function kubectl-dvv-viestit-prod() { aws-vault exec dvv-viestit-prod -- kubectl --kubeconfig ~/.kube/config-dvv-viestit-prod --namespace viestit "$@"; }

export MCFLY_FUZZY=2
export MCFLY_PROMPT="❯"
eval "$(mcfly init zsh)"
