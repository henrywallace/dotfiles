#!/bin/sh
#
# Install Go tools

set -ev

go get -u github.com/nsf/gocode
go get -u github.com/rogpeppe/godef
go get -u golang.org/x/tools/cmd/goimports
go get -u github.com/jstemmer/gotags
