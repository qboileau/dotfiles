## Install

```
#install home files
cd dotfiles/ 
stow -R -t ~ home
```

## Dependencies and utilities 

#### Rofi
`pacman -S rofi rofi-scripts`

#### I3Blocks / i3status-rust
`pacman -S i3blocks`
`yaourt -S i3status-rust`

#### Docker 
```
pacman -S docker docker-compose
systemctl enable docker
systemctl start docker
gpasswd -a $USER docker
#restart session
```

#### Veracrypt
- `pacman -S veracrypt`

#### Dropbox
- `yaourt dropbox`

#### Git  
- `pacman -S git diff-so-fancy`
- `yaourt -S git-standup-git` //git standup
- `yaourt -S git-interactive-rebase-tool`

#### Glances
- `pacman -S glances`

### Others
- `pacman -S feh galculator bash-completion noto-fonts-emoji bat exa ripgrep xorg-xbacklight dnsutils`
- `yaourt ttf-emojione-color` //fonts 
- `yaourt nerd-fonts-complete` //fonts 
- `yaourt -S siji-git` //glyphs fonts
