#!/bin/sh
xrandr --output HDMI-0  --mode 2560x1080 --rate 75.00 &
feh --bg-fill $HOME/Wallpapers/prettyski-catppuccin.png&
dunst&
picom -b &
nm-applet &
