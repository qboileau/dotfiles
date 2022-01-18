#!/bin/bash

set -e

if [ $? -gt 0 ]; then
	echo "Run this script with sudo"
	exit 1
fi
if [ $? -eq ${SUDO_UID} ]; then
	echo "Run this script with sudo"
	exit 1
fi

source_dir="/home/${SUDO_USER}/projects/perso"
home_dir="/home/${SUDO_USER}"

# sudo -u $SUDO_USER mkdir -p ${source_dir}
# cd ${source_dir}
# git clone https://github.com/qboileau/dotfiles.git
# cd dotfile 
cd ~
git clone https://github.com/qboileau/dotfiles.git
cd dotfiles 

echo "Update packages first"
pacman -Syu

"Install packages"
pacman -S --needed - < sed -e '/^\s*#.*$/d' -e '/^\s*$/d' packages.list

echo "Install all dotfiles in $SUDO_USER home"
install -dbv -o $SUDO_USER -g $SUDO_USER ./home $home_dir

echo "Install etc configuration files"
install -dbv -o root -g root ./etc /etc

