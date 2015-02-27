if [ -f /etc/bash_completion ]; then
	    . /etc/bash_completion
fi

xhost +local:root > /dev/null 2>&1

if [ -f ~/.bash_alias ]; then
      . ~/.bash_alias
fi


complete -cf sudo

shopt -s cdspell          #fix misspelling
shopt -s checkwinsize     #update shell to windows size
shopt -s cmdhist          #multi-line history
shopt -s dotglob          #
shopt -s expand_aliases   #
shopt -s extglob          #
shopt -s histappend       #
shopt -s hostcomplete     #

export HISTSIZE=10000
export HISTFILESIZE=${HISTSIZE}
export HISTCONTROL=ignoreboth
export JAVA_FONTS=/usr/share/fonts/TTF
export EDITOR=/usr/bin/nano

#------- Tomcat debuger
export JPDA_ADDRESS=8000
export JPDA_TRANSPORT=dt_socket

# ex - archive extractor
# usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}


# default prompt
#PS1='[\u@\h \W]\$ '

if [ -f ~/.bash_prompt ]; then
      . ~/.bash_prompt
fi
