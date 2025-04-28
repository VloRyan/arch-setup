#!/usr/bin/bash

. functions.sh

if [[ $UID != 0 ]]; then
    echo "Please run this script as root: sudo $0 $*"
    exit 1
fi

if [ $SUDO_USER ]; then
    real_user=$SUDO_USER
else
    real_user=$(whoami)
fi

# Base packages
pacman -S --needed base-devel git pacman-contrib

# mkinitcpio
mkinitcpio_changed=false
if ! is_installed mkinitcpio-numlock; then
  mkdir -p "/home/$real_user/build"
  git clone https://aur.archlinux.org/mkinitcpio-numlock.git "/home/$real_user/build"
  pwd="$PWD"
  cd "/home/$real_user/build/mkinitcpio-numlock" || exit
  sudo -u "$real_user" makepkg -i
  cd "$pwd" || exit
  mkinitcpio_changed=true
fi

if copy_configs "../config/mkinitcpio/" "/etc/"; then
  mkinitcpio_changed=true
fi
if [ $mkinitcpio_changed == true ]; then
  mkinitcpio -P
fi

# Setup system
timedatectl set-ntp true

# Wayland / Sway
pacman -S --needed sway swaybg alacritty waybar wofi xorg-xwayland xorg-xlsclients qt5-wayland glfw-wayland gdm

# Config
sudo -u "$real_user" ./config.sh