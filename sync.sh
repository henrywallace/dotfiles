#!/bin/sh

set -euo pipefail

SYNC_FILES="
  $HOME/.bash_aliases
  $HOME/.bashrc
  $HOME/.emacs.d/init.el
  $HOME/.gitconfig
  $HOME/.gitignore_global
  $HOME/.inputrc
  $HOME/.vimrc
"

R="$(dirname $0)"

for f in $SYNC_FILES; do
  cp "$f" "$R/home/$(basename $f)";
done
