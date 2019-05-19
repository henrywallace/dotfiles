#!/bin/bash

set -e

mkdir -p ~/.zsh

echo "
.aliasrc        $HOME
.bashrc         $HOME
.colors         $HOME
.corerc         $HOME
.envrc          $HOME
.inputrc        $HOME
.pathrc         $HOME

.tmux.conf      $HOME
.zsh/update.sh  $HOME/.zsh

editor          $HOME
git             $HOME
" |
{
  while read -r src dst; do
    if [ -z "$src$dst" ]; then continue; fi
    # If it's a directory, then symlink everything in it.
    if [ ! -d "$src" ]; then
      for subsrc in $(find "$src" -path "$src/*"); do
        ln -nsf "$(realpath "$subsrc")" "$dst"
      done
    else
      ln -nsf "$(realpath "$src")" "$dst"
    fi
  done
}

