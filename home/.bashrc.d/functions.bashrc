#!/usr/bin/env bash

start_postgres () {
       docker start postgres_tabmo_test
}

stop_postgres () {
       docker stop postgres_tabmo_test
}

delete_postgres () {
       docker rm postgres_tabmo_test
}

create_postgres () {
       docker run -d --restart=always --name postgres_tabmo_test --net host -e POSTGRES_USER='tabmo' -e POSTGRES_PASSWORD='tabmo' -v /home/quentin/.sqlmanager:/docker-entrypoint-initdb.d/init-user-db.sh postgres:9.6.2
}

reload_postgres () {
       stop_postgres;
       delete_postgres;
       create_postgres;
}

# rebase current branch to another (default develop)
rebase () {

 rebaseBranch=${1:-"develop"}
 currentBranch=`git symbolic-ref --short -q HEAD`
 if [ `git status --porcelain 2>/dev/null| egrep "^(M| M)" | wc -l` -ne 0 ]; then
   dirty=true
 else
   dirty=false
 fi

 echo "##### Rebase branch ${currentBranch} -> ${rebaseBranch} with dirty:${dirty}"

 if [ "$dirty" = true ]; then
   echo "##### Stash modifications"
   git stash
 fi

 echo  "#### Update current"
 git pull --rebase

 echo  "#### Update develop"
 git checkout $rebaseBranch
 git pull --rebase

 echo  "#### Rebase"
 git co $currentBranch
 git rebase -i $rebaseBranch

 read -p "Force push rebase result to origin (y/n)?" -n 1 -r
 echo    # (optional) move to a new line
 if [[ $REPLY =~ ^[Yy]$ ]] ;then
   if [[ "$currentBranch" -eq "develop" || "$currentBranch" -eq "master" ]] ;then
     echo "FORCE PUSH TO MASTER OR DEVELOP BRANCHES NOT ALLOWED"
   else
     git push -f origin $currentBranch
   fi
 fi

 if [ "$dirty" = true ]; then
   echo  "#### Re-apply modifications"
   git stash pop
 fi
}


test_in_worktree() {

  test_branch=${1:-"develop"} | sed -r 's/[\/]+/-/g'

  project_dir=`pwd`
  test_dir=$project_dir-test-$test_branch
  mkdir $test_dir
  echo "Create worktree for branch $test_branch on directory $test_dir"
  git worktree add --detach $test_dir $test_branch
  cd $test_dir
  pwd

  echo "Run tests"
  sbt test

  cd $project_dir
  echo "Remove test dir $test_dir"
  rm -rf $test_dir
}


# ex - archive extractor
# usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1 -C $2 ;;
      *.tar.gz)    tar xzf $1 -C $2  ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1  -C $2  ;;
      *.tbz2)      tar xjf $1 -C $2  ;;
      *.tgz)       tar xzf $1 -C $2  ;;
      *.zip)       unzip $1   -d $2  ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}


colors() {
  local fgc bgc vals seq0

  printf "Color escapes are %s\n" '\e[${value};...;${value}m'
  printf "Values 30..37 are \e[33mforeground colors\e[m\n"
  printf "Values 40..47 are \e[43mbackground colors\e[m\n"
  printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

  # foreground colors
  for fgc in {30..37}; do
    # background colors
    for bgc in {40..47}; do
      fgc=${fgc#37} # white
      bgc=${bgc#40} # black

      vals="${fgc:+$fgc;}${bgc}"
      vals=${vals%%;}

      seq0="${vals:+\e[${vals}m}"
      printf "  %-9s" "${seq0:-(default)}"
      printf " ${seq0}TEXT\e[m"
      printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
    done
    echo; echo
  done
}