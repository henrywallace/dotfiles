#!/bin/sh

set -e

PKGS=$(echo */)
echo "stowing packages: $PKGS\n"
tree -a -I *~ $PKGS

stow $PKGS && echo 'success!' || echo 'failed to stow'
