#!/bin/sh
xrandr --output HDMI-0  --mode 2560x1080 --rate 75.00 &
feh --bg-fill $HOME/Wallpapers/mando-nord.png&
picom -b&
dunst &
nm-applet &
