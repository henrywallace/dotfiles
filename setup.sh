#!/bin/bash

set -e

mkdir -p ~/.zsh
mkdir -p ~/bin

# Maybe link a src file to a dst. If the src is not a file, then this returns a
# non-zero value. If dst is a directory, then the src is attempted to be linked
# into that directory. This returns a non-zero value if symbolic linking fails.
maybelink() {
  local src=$1
  local dst=$2
  if [ -d "$src" ]; then
    return 1
  fi
  if [ -d "$dst" ]; then
    dst=$dst/$(basename "$src")
  fi
  if [ -L "$dst" ] && [ "$(realpath "$src")" == "$(realpath "$dst")" ]; then
    return 0
  fi
  if [ ! -e "$dst" ]; then
    # If it's a broken symlink then force the linking.
    ln -sf "$(realpath "$src")" "$dst"
  else
    ln -s "$(realpath "$src")" "$dst"
  fi
}

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
.zshrc          $HOME
.xinitrc        $HOME
.Xresources     $HOME
.Xmodmap        $HOME
bin             $HOME/bin
editor          $HOME
git             $HOME
" |
{
  while read -r src dst; do
    # Skip if it's a blank line or starts with a commment.
    if [ -z "$src$dst" ] || echo "$src" | grep -q '^#'; then
      continue
    fi
    # If it's a directory, then symlink everything in it.
    if [ -d "$src" ]; then
      if [ -e "$dst" ] && [ ! -d "$dst" ]; then
        echo "dst can't be a file for directory src, src=$src/, dst=$dst"
        continue
      fi
      for subsrc in $(find "$src" -path "$src/*"); do
        maybelink "$subsrc" "$dst" || continue
      done
    else
      maybelink "$src" "$dst" || continue
    fi
  done
}
