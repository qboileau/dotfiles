## Install

```
#install home files
cd dotfiles/ 
stow -R -t ~ home
```

## Dependencies and utilities 

#### Rofi
`pacman -S rofi rofy-scripts`

#### I3Blocks
`pacman -S i3blocks`

#### Docker 
```
pacman -S docker docker-compose
systemctl enable docker
systemctl start docker
gpasswd -a $USER docker
#restart session
```

#### Veracrypt
`pacman -S veracrypt`

#### Dropbox
`yaourt dropbox`

#### Git
`pacman -S git diff-so-fancy`

#### Glances
`pacman -S glances`


### Others
`pacman -S feh`
`pacman -S galculator`
`pacman -S bash-completion`
`pacman -S xorg-xbacklight`
`pacman -S noto-fonts-emoji`
`yaourt ttf-emojione-color`
