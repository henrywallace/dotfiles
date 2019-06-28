#!/bin/sh

echo "
https://github.com/zsh-users/zsh-autosuggestions
https://github.com/zsh-users/zsh-syntax-highlighting
https://github.com/sindresorhus/pure
https://github.com/zdharma/fast-syntax-highlighting
" |
{
  while read -r repo; do
    [ -z "$repo" ] && continue
    tput setaf 4; echo "$repo"; tput sgr0
    DST="$HOME/.zsh/$(basename "$repo")"
    [ -d "$DST" ] || git clone "$repo" "$DST"
    git -C "$DST" fetch
    diff=$(git -C "$DST" diff master origin/master)
    if [ -n "$diff" ]; then
      echo -n "Pull these changes? (Y/n)"
      read -r answer
      if [ -z "$answer" ] || rg -iq "^y"; then
        git -C "$DST" pull
      fi
    fi
  done
}

# https://github.com/sindresorhus/pure#manually
mkdir -p "$HOME/.zfunctions"
ln -nsf "$HOME/.zsh/pure/pure.zsh" "$HOME/.zfunctions/prompt_pure_setup"
ln -nsf "$HOME/.zsh/pure/async.zsh" "$HOME/.zfunctions/async"
