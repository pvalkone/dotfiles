#
# ~/.bashrc
#

if [ -f ~/bin/sensible.bash ]; then
   source ~/bin/sensible.bash
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

UNAME=$(uname)
source ~/.bashrc-${UNAME,,}

alias g='git'
alias rg="rg --colors line:fg:yellow \
             --colors line:style:bold \
             --colors path:fg:green \
             --colors path:style:bold \
             --colors match:fg:black \
             --colors match:bg:yellow \
             --colors match:style:nobold"

export EDITOR=`which vim`
export PAGER=`which less`
export LESS="-r -X"
export JAVA_HOME="/usr/lib/jvm/default"
export SCALA_HOME="/usr/share/scala"

source `locate git-prompt.sh`
GIT_PS1_SHOWCOLORHINTS=1
PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'
