if [ -f /etc/bash_completion ]; then
	    . /etc/bash_completion
fi

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion

#git auto completion
source /usr/share/git/completion/git-completion.bash

xhost +local:root > /dev/null 2>&1

complete -cf sudo

shopt -s cdspell          #fix misspelling
shopt -s checkwinsize     #update shell to windows size
shopt -s cmdhist          #multi-line history
shopt -s dotglob          #
shopt -s expand_aliases   #
shopt -s extglob          #
shopt -s histappend       #
shopt -s hostcomplete     #

# better yaourt colors
export YAOURT_COLORS="nb=1:pkg=1:ver=1;32:lver=1;45:installed=1;42:grp=1;34:od=1;41;5:votes=1;44:dsc=0:other=1;35"

export HISTSIZE=10000
export HISTFILESIZE=${HISTSIZE}
export HISTCONTROL=ignoreboth
export JAVA_FONTS=/usr/share/fonts/TTF
export EDITOR=/bin/nano
export BROWSER=google-chrome-stable

#export JAVA_HOME=/usr/lib/jvm/java-8-oracle
export MAVEN_OPTS="-Xmx1g -XX:MaxPermSize=512m"
export SBT_OPTS="-Xms256m -Xmx2G"

export PATH="$HOME/.local/bin":$PATH
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.gem/ruby/2.5.0/bin:$PATH"

#sources bash extensions
for file in ~/.bashrc.d/*.bashrc; do
 source "$file"
 unset file
done

# added by travis gem
[ -f /home/qboileau/.travis/travis.sh ] && source /home/qboileau/.travis/travis.sh
