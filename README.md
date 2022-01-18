## Install

```
#install home files
cd dotfiles/ 
stow -R -t ~ home

# enable ssh-agent autostart
systemctl --user enable ssh-agent.service
systemctl --user start ssh-agent.service
```

## Dependencies and utilities 

#### Rofi
`pacman -S rofi rofi-scripts`

#### I3Blocks / i3status-rust
`pacman -S i3blocks`
`yay -S i3status-rust`

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
- `yay dropbox`

#### Git  
- `pacman -S git diff-so-fancy`
- `yay -S git-standup-git` //git standup
- `yay -S git-interactive-rebase-tool`

#### Glances
- `pacman -S glances`

### Others
- `pacman -S feh galculator bash-completion noto-fonts-emoji bat exa ripgrep xorg-xbacklight dnsutils xss-lock s-tui`
- `yay ttf-emojione-color` //fonts 
- `yay nerd-fonts-complete` //fonts 
- `yay -S siji-git` //glyphs fonts
- `yay -S sd` // sed replacement

# Gaming
- `pacman -S gamemode` // Gamemode optimizations
- `yay -S goverlay` // Vulkan/OpenGL overlays.
- `pacman -S piper` // gaming mouse configuration GUI
- `yay -S noisetorch` // noise reductor
- `pacman -S discord` // Discord