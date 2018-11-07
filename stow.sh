#!/bin/sh

set -e

PKGS=$(echo */)
echo "stowing packages $(echo $PKGS)"
stow $PKGS && echo 'success!' || echo 'failed to stow'
