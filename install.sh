#!/bin/bash

set -e

if [ $? -gt 0 ]; then
	echo "Run this script with sudo"
	exit 1
fi
# if [ $? = ${SUDO_UID} ]; then
# 	echo "Run this script with sudo"
# 	exit 1
# fi
branch=${DOTFILES_BRANCH:-auto-install}

# get arch ID, ex: arch or manjaro
dist="$(grep "^ID=" /etc/os-release | awk '{split($0,a,"="); print a[2]}')"

source_dir="/home/${SUDO_USER}/projects/perso"
home_dir="/home/${SUDO_USER}"

# sudo -u $SUDO_USER mkdir -p ${source_dir}
# cd ${source_dir}
# git clone https://github.com/qboileau/dotfiles.git
# cd dotfile 
cd ~
git clone -b auto-install https://github.com/qboileau/dotfiles.git
cd dotfiles 

echo "Update packages first"
pacman -Syyu --noconfirm

echo "Install packages"
sed -e '/^\s*#.*$/d' -e '/^\s*$/d' ./packages/"$dist"_packages.list > /tmp/clean_packages.list
packages="$(tr '\r\n' ' ' < /tmp/clean_packages.list)"
echo -e "Package to install : \n$packages"
pacman -S --noconfirm --needed $packages

# pacman -S --noconfirm --needed $(sed -e '/^\s*#.*$/d' -e '/^\s*$/d' packages.list)
#pacman -S --noconfirm --needed - < packages.list

echo "Install rust stable toolchain"
rustup default stable
rustup install stable
rustup show

echo "Install AUR packages"
sed -e '/^\s*#.*$/d' -e '/^\s*$/d' ./packages/"$dist"_packages_aur.list > /tmp/clean_packages_aur.list
aur_packages="$(tr '\r\n' ' ' < /tmp/clean_packages_aur.list)"
echo -e "AUR package to install : \n$aur_packages"
yay -S --noconfirm --noprovides --needed $aur_packages

echo "Install all dotfiles in $SUDO_USER home"
install -dbv -o $SUDO_USER -g $SUDO_USER ./home $home_dir

echo "Install etc configuration files"
install -dbv -o root -g root ./etc /etc

