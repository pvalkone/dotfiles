[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
rvm use default &> /dev/null

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/ttyv0 ]]; then exec startx; fi
