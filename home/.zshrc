#!/bin/zsh

# Completion. We do this first in case anything below wants to set up
# completion additional definitions.
autoload -Uz compinit; compinit

# Allow completing aliases.
setopt completealiases

# Base shell-agnostic rc.
. ~/.corerc

if command -v kubectl &>/dev/null; then
  . <(kubectl completion zsh)
fi

[ -f $HOME/.cargo/env ] && . $HOME/.cargo/env

fpath=( "$HOME/.zfunctions" $fpath )

if [ -f /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Tab complete dir colors.
# https://github.com/robbyrussell/oh-my-zsh/issues/1563#issuecomment-26591369.
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"

# Allow completing inside of words.
setopt completeinword

# Bash-style delete word backwards.
autoload -Uz select-word-style
select-word-style whitespace

# Remove command lines from the history list when the first character on the
# line is a space, or when one of the expanded aliases contains a leading
# space. Note that the command lingers in the internal history until the next
# command is entered before it vanishes, allowing you to briefly reuse or edit
# the line. If you want to make it vanish right away without entering another
# command, type a space and press return.
setopt HIST_IGNORE_SPACE

# Allow writing comment lines in interactive shell, like bash.
# https://stackoverflow.com/a/11873793
setopt interactivecomments

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

# https://github.com/zsh-users/zsh-autosuggestions#key-bindings
bindkey '^ ' autosuggest-accept
bindkey '^@' autosuggest-accept

eval "$(starship init zsh)"

# Don't add anything to $PATH if it's there already.
# https://wiki.archlinux.org/index.php/zsh
# https://stackoverflow.com/a/13060074/2601179
typeset -gU path

# Enable autocompletion of privileged environments in privileged commands, e.g.
# sudo prefixed.
zstyle ':completion::complete:*' gain-privileges 1

ZSH_AUTOSUGGESTIONS=~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
if [ -f "$ZSH_AUTOSUGGESTIONS" ]; then
  . "$ZSH_AUTOSUGGESTIONS"
fi

# Fish-like syntax highlighting.
ZSH_SYNTAX_HIGHLIGHTING=~/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
if [ -f "$ZSH_SYNTAX_HIGHLIGHTING" ]; then
  . "$ZSH_SYNTAX_HIGHLIGHTING"
fi

ZSH_COMPLETIONS=~/.zsh/zsh-completions
if [ -d "$ZSH_COMPLETIONS" ]; then
  fpath=($ZSH_COMPLETIONS $fpath)
fi

# Use emacs mode.
bindkey -e

# https://github.com/jwilm/alacritty/issues/1408#issuecomment-467970836
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[1;OC" forward-word
bindkey "^[[1;OD" backward-word

bindkey "^[[3" backward-delete-char

# History.
HISTFILE=~/.zsh_history
HISTSIZE=10000000  # 10^7
SAVEHIST=10000000
setopt APPEND_HISTORY     # append hist after each session
setopt EXTENDED_HISTORY   # save timestamp
setopt HIST_REDUCE_BLANKS # dont save blanks

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
