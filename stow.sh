#!/bin/bash

set -e

PKGS="$(echo */) .debug .zsh"
echo "stowing packages: $PKGS\n"
if [[ -x "$(command -v tree)" ]]; then
  tree -a -I *~ $PKGS
fi

stow $PKGS && echo 'success!' || echo 'failed to stow'
