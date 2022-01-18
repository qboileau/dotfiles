#!/bin/bash

set -e

if [ $? -gt 0 ]; then
	echo "Run as Root"
fi

echo "Update packages first"
pacman -Syu

echo "Install packages"
pacman -S \
 git \
 diff-so-fancy \
 glances \
 i3blocks \
 i3status-rust \
 i3-scrot \
 i3-gaps \
 i3locks \
 i3exit \
 rofi \
 rofi-scripts \
 docker \
 docker-compose \
 feh \
 galculator \
 bash-completion \
 noto-fonts-emoji \
 bat \
 exa \
 ripgrep \
 xorg-xbacklight \
 dnsutils \
 httpie \
 fd \
 duf \
 tldr \
 xss-lock \
 s-tui \
