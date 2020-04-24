#!/bin/bash

repo=https://github.com/tmux-plugins/tpm
dst=~/.tmux/plugins/tpm
if [ ! -d ~/.tmux/plugins/tpm ]; then
  git clone "$repo" "$dst"
fi
tput setaf 4; echo "$repo"; tput sgr0
git -C "$dst" pull


