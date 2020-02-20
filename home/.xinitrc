#!/bin/bash

#export XDG_SESSION_TYPE=x11
#export GDK_BACKEND=x11
#exec gnome-session

xrandr --dpi 220
xset r rate 200 35

[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

if command -v redshift &>/dev/null; then
  redshift -P -O 4500
fi

exec i3
