#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias g="git"

export EDITOR="$(which vim)"
export PAGER="$(which less)"
export LESS="-r -X"
export RIPGREP_CONFIG_PATH="${HOME}/.ripgreprc"

eval "$(starship init bash)"
eval "$(mcfly init bash)"
