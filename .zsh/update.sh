#!/bin/sh

for repo in zsh-autosuggestions zsh-syntax-highlighting; do
  tput setaf 4; echo "$repo"; tput sgr0
  [ -d "$repo" ] || git clone "https://github.com/zsh-users/$repo"
  git -C "$repo" pull
done
