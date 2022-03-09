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

echo "Update packages first"
pacman -Syyu --noconfirm

echo "Check dependencies"
pacman --noconfirm -S git sudo go
yay --version
if [[ $? -gt 0 ]]; then
	echo "Install yay"
	exit 1
fi

branch="${DOTFILES_BRANCH:-auto-install}"

# get arch ID, ex: arch or manjaro
dist="$(grep "^ID=" /etc/os-release | awk '{split($0,a,"="); print a[2]}')"

source_dir="/opt"
if [ $? = ${SUDO_UID} ]; then
	home_dir="/root"
else 
	home_dir="/home/${SUDO_USER}"
fi

cd ${source_dir}
if [[ -d "${source_dir}/dotfiles" ]]
then
	echo "Dotfile already cloned in ${source_dir}/dotfiles directory"
else 
	git clone -b "${branch}" https://github.com/qboileau/dotfiles.git
	chown -R "${SUDO_USER}":"${SUDO_USER}" ./dotfiles/home
fi
cd dotfiles 


echo "Install packages"
sed -e '/^\s*#.*$/d' -e '/^\s*$/d' ./packages/"$dist"_packages.list > /tmp/clean_packages.list
packages="$(tr '\r\n' ' ' < /tmp/clean_packages.list)"
echo -e "Package to install : \n$packages"
pacman -S --noconfirm --needed $packages

echo "Install rust stable toolchain"
rustup default stable
rustup show

echo "Install AUR packages"
sed -e '/^\s*#.*$/d' -e '/^\s*$/d' ./packages/"$dist"_packages_aur.list > /tmp/clean_packages_aur.list
aur_packages="$(tr '\r\n' ' ' < /tmp/clean_packages_aur.list)"
echo -e "AUR package to install : \n$aur_packages"
yay -S --noconfirm --noprovides --needed $aur_packages

echo "Install RStow"
cargo install --git https://github.com/qboileau/rstow.git
export PATH=$PATH:~/.cargo/bin

echo "Install all dotfiles in $SUDO_USER home"
rstow --force --backup --source ${source_dir}/dotfiles/home --target $home_dir -vv
# install -dbv -o $SUDO_USER -g $SUDO_USER ./home $home_dir

echo "Install etc configuration files"
rstow --force --backup --source ${source_dir}/dotfiles/etc --target /etc -vv
# install -dbv -o root -g root ./etc /etc

