#!/usr/bin/env bash

alias ls='exa --group-directories-first --time-style=long-iso --git --color=auto -F --octal-permissions'
alias ll='exa -lah --group-directories-first --time-style=long-iso --git --color=auto -F --octal-permissions'
alias tree='exa -lah --group-directories-first --time-style=long-iso --git --color=auto --tree -F'
alias grep='rg'
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano PKGBUILD'
alias ip='ip --color'
alias ipb='ip --color --brief'
alias cat='bat'
alias df='duf'
alias git='LANG="en_US.UTF-8" git'

alias ssh='TERM=xterm-color ssh'

alias source_bash='source ~/.bashrc'
alias updateBash='source ~/.bashrc'
alias updateXresources='xrdb ~/.Xresources'

#Maven
alias mvncis='mvn clean install -DskipTests --show-version'
alias mvnc='mvn clean --show-version'
alias mvni='mvn install --show-version'
alias mvnis='mvn install -DskipTests --show-version'
alias mvnci='mvn clean install --show-version'
alias mvnt='mvn test --show-version'

#Pacman
alias fixit='sudo rm -f /var/lib/pacman/db.lck'
alias inst='sudo pacman -S'
alias mirrors='sudo pacman-mirrors -g'
alias update='yaourt -Syua'

alias azerty='setxkbmap -model pc105 -layout fr -variant azerty'
alias qwerty='setxkbmap -model pc105 -layout us -variant alt-intl'


alias calc='galculator'
alias notes='xournalpp'
