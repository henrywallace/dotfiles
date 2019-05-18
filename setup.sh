#!/bin/bash

set -e

PKGS="$(echo */) .debug .zsh"
echo "stowing packages: $PKGS"
if [[ -x "$(command -v tree)" ]]; then
  tree -a -I *~ $PKGS
fi

stow $PKGS && echo 'success!' || echo 'failed to stow'

ln -sfn "$(realpath .zsh/update.sh)" ~/.zsh

