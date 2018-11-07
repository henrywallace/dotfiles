autoload -Uz compinit; compinit
autoload -Uz promptinit; promptinit

# https://unix.stackexchange.com/a/258661/162041
autoload -U select-word-style; select-word-style bash

# https://github.com/sindresorhus/pure
prompt pure

# Don't add anything to $PATH if it's there already.
# https://wiki.archlinux.org/index.php/zsh
# https://stackoverflow.com/a/13060074/2601179
typeset -gU path

# Enable autocompletion of privileged environments in privileged
# commands, e.g. sudo prefixed.
zstyle ':completion::complete:*' gain-privileges 1

# Use emacs mode.
bindkey -e

. ~/.envrc
. $HOME/.aliasrc

