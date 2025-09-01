#!/bin/sh
xrandr --auto --below eDP-1
feh --bg-fill $HOME/Wallpapers/gray.png&
dunst&
picom -b &
nm-applet &
