#!/bin/bash

repos="
https://github.com/zsh-users/zsh-autosuggestions
https://github.com/zdharma/fast-syntax-highlighting
https://github.com/zsh-users/zsh-completions
https://github.com/sindresorhus/pure
"
for repo in $repos; do
  [ -z "$repo" ] && continue
  tput setaf 4; echo "$repo"; tput sgr0
  dst="$HOME/.zsh/$(basename "$repo")"
  [ -d "$dst" ] || git clone "$repo" "$dst"
  git -C "$dst" fetch
  diff=$(git -C "$dst" diff HEAD..origin/master)
  if [ -n "$diff" ]; then
    git -C "$dst" log -p --stat HEAD..origin/master
    echo -n "Pull these changes? (Y/n) "
    read -r answer
    if [ -z "$answer" ] || rg -iq "^y"; then
      git -C "$dst" pull
    fi
  fi
done

# https://github.com/sindresorhus/pure#manually
mkdir -p "$HOME/.zfunctions"
ln -nsf "$HOME/.zsh/pure/pure.zsh" "$HOME/.zfunctions/prompt_pure_setup"
ln -nsf "$HOME/.zsh/pure/async.zsh" "$HOME/.zfunctions/async"
