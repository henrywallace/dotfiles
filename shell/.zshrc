# Base shell-agnostic rc.
. ~/.corerc

# Tab complete dir colors.
# https://github.com/robbyrussell/oh-my-zsh/issues/1563#issuecomment-26591369.
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"

# Completion.
autoload -Uz compinit; compinit

# Allow delete back part, not full word, like bash.
# https://unix.stackexchange.com/a/258661/162041
autoload -U select-word-style; select-word-style bash

# Highlight tab completion selection.
# https://stackoverflow.com/a/29197217/2601179
zstyle ':completion:*' menu select

# Shift-tab.
# https://stackoverflow.com/a/842370/2601179
bindkey '^[[Z' reverse-menu-complete

# Prompt.
autoload -Uz promptinit; promptinit
# https://github.com/sindresorhus/pure
prompt pure

# Don't add anything to $PATH if it's there already.
# https://wiki.archlinux.org/index.php/zsh
# https://stackoverflow.com/a/13060074/2601179
typeset -gU path

# Enable autocompletion of privileged environments in privileged commands, e.g.
# sudo prefixed.
zstyle ':completion::complete:*' gain-privileges 1

# # Fish-like syntax hlghlighting.
# # https://github.com/zsh-users/zsh-syntax-highlighting
# if test -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh; then
#   . /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# fi

# Use emacs mode.
bindkey -e

# History.
HISTFILE=~/.zsh_history
HISTSIZE=10000000  # 10^7
SAVEHIST=10000000
setopt APPEND_HISTORY     # append hist after each session
setopt EXTENDED_HISTORY   # save timestamp
setopt HIST_REDUCE_BLANKS # dont save blanks

