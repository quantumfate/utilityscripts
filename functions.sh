fancy-keygen() {
	ssh-keygen -o -a 100 -t ed25519 -f ~/.ssh/$1 -C leonconnorholm@gmail.com
}

clip_this() {
  cat $1 | xclip -sel clip
}
