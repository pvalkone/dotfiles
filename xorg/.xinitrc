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
setxkbmap -rules evdev -model evdev -layout us -variant altgr-intl
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

xcalib -display ${DISPLAY} -screen 0 ${HOME}/.local/share/icc/$(hostname -s).icc

autocutsel -fork &
autocutsel -selection PRIMARY -fork &

export BROWSER=firefox

exec i3
