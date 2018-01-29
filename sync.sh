#!/bin/sh

set -e

HOME_FILES="
  .aliases
  .bashrc
  .colors
  .emacs.el
  .gitconfig
  .gitignore_global
  .inputrc
  .misc
  .vimrc
"

for f in $HOME_FILES; do
  cp -r "$HOME/$f" "$(dirname $0)/home/$f" 2> /dev/null || echo "missing file $HOME/$f";
done
