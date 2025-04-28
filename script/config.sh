#!/usr/bin/bash

. functions.sh

if [[ $UID == 0 ]]; then
    echo "Please run this script as user"
    exit 1
fi

copy_configs ../config/sway/ ~/.config/sway/
copy_configs ../config/waybar/ ~/.config/waybar/
copy_configs ../config/alacritty/ ~/.config/alacritty/
copy_configs ../config/wofi/ ~/.config/wofi/