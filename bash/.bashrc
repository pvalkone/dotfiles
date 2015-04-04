#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

export EDITOR=/usr/bin/vim
export PATH=$PATH:$HOME/bin
export LESS="-R"
export LESSOPEN="|~/.lessfilter %s"

source /usr/share/git/completion/git-prompt.sh
GIT_PS1_SHOWCOLORHINTS=1
PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'
