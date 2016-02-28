#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

if [ -f ~/.Xresources ]; then
  xrdb -merge ~/.Xresources
fi
setxkbmap fi -option terminate:ctrl_alt_bksp
if [ -f ~/.xmodmaprc ]; then
  xmodmap ~/.xmodmaprc
fi
xset b off
xset s 600
xhost +si:localuser:root
if [ -f ~/.fehbg ]; then
  . ~/.fehbg
fi
unclutter -root -visible -idle 1 &

LOCATION=$(curl --silent --fail ipinfo.io/loc | tr ',' ':')
redshift -l ${LOCATION:=60.1708:24.9375} &

exec i3
