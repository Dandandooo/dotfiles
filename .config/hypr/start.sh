#!/usr/bin/env bash

# initialize wallpaper daemon
swww init &
# set wallpaper
swww img ~/.config/wallpapers/sushigrassgray.png &

waybar
