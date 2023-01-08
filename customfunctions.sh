#!/bin/bash

# Extract any archive
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
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

# Generate a ssh key the cool way
fancy-keygen() {
	ssh-keygen -o -a 100 -t ed25519 -f ~/.ssh/$1 -C leonconnorholm@gmail.com
}

# Copy something to system clipboard
clip_this() {
  cat $1 | xclip -sel clip 
}

# Git alias to write commit messages without pesky flags
cgit() {
  git commit -m "$1"
}

# Dotbare alias to write commit messages without pesky flags
cgit() {
dotbare commit -m "$1"
}
