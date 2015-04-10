#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias g='git'

export EDITOR=/usr/bin/vim
export PATH=$PATH:$HOME/bin:/opt/bin
export LESS="-R"
export LESSOPEN="| pygmentize -f terminal256 -O style=solarizeddark -g %s"
export JAVA_HOME="/usr/lib/jvm/default"
export SCALA_HOME="/usr/share/scala"

source /usr/share/git/completion/git-prompt.sh
GIT_PS1_SHOWCOLORHINTS=1
PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'
