#!/bin/sh

set -euo pipefail

SYNC_FILES="
  $HOME/.vimrc
  $HOME/.bashrc
  $HOME/.bash_aliases
  $HOME/.inputrc
"

R="$(dirname $0)"

for f in $SYNC_FILES; do
  cp "$f" "$R/home/$(basename $f)";
done
