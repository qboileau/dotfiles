#!/usr/bin/env bash

alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias ll='ls -la --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias grep='grep --color=tty -d skip'
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano PKGBUILD'
alias tree='tree -h'

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
