#!/bin/sh

set -euo pipefail

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
  cp "$HOME/$f" "$(dirname $0)/home/$f";
done
