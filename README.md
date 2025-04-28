# arch-setup

This repo contains configurations and scripts for setting up an initial arch linux installation.

# Prerequisites

* Basic installation of Arch ([Installation guide](https://wiki.archlinux.org/title/Installation_guide))
* Internet connection

# Run

```bash
  sudo ./scripts/init.sh
```

# Scripts

## init.sh

Will initialize the system as root:

* Install base packages
* Configure mkinitcpio
* Configure time
* Install wayland / sway

Afterward config.sh is called with user permissions.

## config.sh

Will do the user configuration of:

* Sway
* Wofi
* Waybar
* Alacritty

# Open issues

1. sway config is general with commented out special setting for VloRyan-NB