#!/bin/sh

for repo in zsh-autosuggestions zsh-syntax-highlighting; do
  tput setaf 4; echo "$repo"; tput sgr0
  DST="$HOME/.zsh/$repo"
  [ -d "$DST" ] || git clone "https://github.com/zsh-users/$repo" "$DST"
  git -C "$DST" pull
done
