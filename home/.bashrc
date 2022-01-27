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

export TERMINAL=alacritty
export TERM=alacritty

export HISTSIZE=10000
export HISTFILESIZE=${HISTSIZE}
export HISTCONTROL=ignoreboth
export JAVA_FONTS=/usr/share/fonts/TTF
export EDITOR=/bin/nano

export JAVA_HOME=/usr/lib/jvm/default
export MAVEN_OPTS="-Xmx1g -XX:MaxPermSize=512m"
export SBT_OPTS="-Xms256m -Xmx2G"

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/go/bin/:$PATH"
export PATH="$HOME/bin/:$PATH"
#Android build tools
export PATH="~/projects/perso/Andoid_build/tools/plateform-tools:$PATH"

export KUBECONFIG="/home/qboileau/.kube/config-th3:/home/qboileau/.kube/config-minikube"

# sources bash extensions
for file in ~/.bashrc.d/*.bashrc; do
 source "$file"
 unset file
done

# added by travis gem
[ -f /home/qboileau/.travis/travis.sh ] && source /home/qboileau/.travis/travis.sh

# source nvm if exist
[ -f /usr/share/nvm/init-nvm.sh ] && source /usr/share/nvm/init-nvm.sh

# super prompt
eval "$(starship init bash)"

