#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias g='git'
alias rg="rg --colors line:fg:yellow \
             --colors line:style:bold \
             --colors path:fg:green \
             --colors path:style:bold \
             --colors match:fg:black \
             --colors match:bg:yellow \
             --colors match:style:nobold"
alias vim='nvim'

export EDITOR=`which nvim`
export PAGER=`which less`
export LESS="-r -X"

eval "$(starship init bash)"
