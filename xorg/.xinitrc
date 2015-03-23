#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
setxkbmap fi -option terminate:ctrl_alt_bksp
[[ -f ~/.xmodmaprc ]] && xmodmap ~/.xmodmaprc
xset b off
xset s 600
[[ -f ~/.fehbg ]] && source ~/.fehbg
unclutter -root -visible -idle 1 &
syndaemon -tkd
synclient TouchpadOff=1
redshift || redshift -l 60.1708:24.9375 &

exec i3
