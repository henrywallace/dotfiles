#!/bin/bash

set -euo pipefail

# rust
curl https://sh.rustup.rs -sSf | sh -s -- -y

# Install ripgrep from source
# cargo install --force ripgrep

# vim plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

PKGS='tree'

# platform specific
case $(uname) in
    Darwin)
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	for pkg in $PKGS; do
	    echo "installing: $pkg"
	    brew install "$pkg"
	done
	;;
    Linux)
	type apt-get >/dev/null 2>&1 || { echo >&2 "I require apt-get but it's not installed.  Aborting."; exit 1; }
	SYS_PKG='build-essential'
	for pkg in $SYS_PKG; do
	    echo "installing system package $pkg"
	    sudo apt-get install -y "$pkg"
	done
	for pkg in $PKGS; do
	    echo "installing: $pkg"
	    sudo apt-get install -y "$pkg"
	done
	;;
esac
