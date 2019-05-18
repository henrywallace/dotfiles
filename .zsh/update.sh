#!/bin/sh

D=$(dirname "$(readlink -f "$0")")
for repo in zsh-autosuggestions zsh-syntax-highlighting; do
  tput setaf 4; echo "$repo"; tput sgr0
  [ -d "$D/$repo" ] || git clone "https://github.com/zsh-users/$repo" "$D/$repo"
  git -C "$D/$repo" pull
done
