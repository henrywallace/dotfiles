#!/bin/sh

set -e

HOME_FILES="
  .bash_aliases
  .bashrc
  .emacs.el
  .gitconfig
  .gitignore_global
  .inputrc
  .vimrc
"

for f in $HOME_FILES; do
  cp "$HOME/$f" "$(dirname $0)/home/$f" 2> /dev/null || echo "missing local $HOME/$f";
done
