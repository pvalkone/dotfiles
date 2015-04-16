#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

UNAME=$(uname)
source ~/.bashrc-${UNAME,,}

alias g='git'

export EDITOR=`which vim`
export PAGER=`which less`
export PATH=$PATH:$HOME/bin:/opt/bin
export LESS="-R"
export LESSOPEN="| pygmentize -f terminal256 -O style=solarizeddark -g %s"
export JAVA_HOME="/usr/lib/jvm/default"
export SCALA_HOME="/usr/share/scala"

source `locate git-prompt.sh`
GIT_PS1_SHOWCOLORHINTS=1
PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'
