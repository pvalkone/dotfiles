#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

# https://wiki.archlinux.org/index.php/Tmux#Start_tmux_on_every_shell_login
([[ -x "$(command -v tmux)" ]] && [[ -z "$TMUX" ]]) && (tmux attach || tmux new-session)
