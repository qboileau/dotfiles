if [ -f /etc/bash_completion ]; then
	    . /etc/bash_completion
fi

#git auto completion
source /usr/share/git/completion/git-completion.bash

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
export EDITOR=/bin/nano

export JAVA_HOME=/usr/lib/jvm/java-7-oracle
export M2_HOME=/opt/maven
export MAVEN_OPTS="-Xmx1g -XX:MaxPermSize=512m"
export SBT_OPTS="-Xms2024m -Xmx3G"

export PATH=$HOME/apps/activator-1.3.10-minimal/bin:$PATH
export PATH=$HOME/apps/idea-IC-162.1628.40/bin:$PATH
export PATH=$HOME/local/bin:$PATH


# default prompt
#PS1='[\u@\h \W]\$ '

if [ -f ~/.bash_prompt ]; then
      . ~/.bash_prompt
fi

if [ -f ~/.bash_fun ]; then
      . ~/.bash_fun
fi

if [ -f ~/.bash_work ]; then
      . ~/.bash_work
fi
