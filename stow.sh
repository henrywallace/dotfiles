#!/bin/sh

set -e


# if ! hash stow &>/dev/null || ! hash fd &>/dev/null; then
#     echo 'please install `stow` and `fd` with install.sh'
#     exit 1
# fi

PKGS=$(fd -t d)
echo "stowing packages $(echo $PKGS)"
stow $PKGS && echo 'success!' || echo 'failed to stow'
