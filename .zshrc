# Base shell-agnostic rc.
. ~/.corerc

fpath=( "$HOME/.zfunctions" $fpath )

# Tab complete dir colors.
# https://github.com/robbyrussell/oh-my-zsh/issues/1563#issuecomment-26591369.
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"

# Completion.
autoload -Uz compinit; compinit

# Allow completing inside of words.
setopt completeinword

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

# https://vi.stackexchange.com/a/10142
set formatoptions+=r
# set comments-=mb:*
# set comments+=fb:*

prompt pure
PURE_CMD_MAX_EXEC_TIME=2
PURE_PROMPT_SYMBOL='%%'

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

# Fish-like syntax hlghlighting.
ZSH_SYNTAX_HIGHLIGHTING=~/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
if [ -f "$ZSH_SYNTAX_HIGHLIGHTING" ]; then
  . "$ZSH_SYNTAX_HIGHLIGHTING"
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

# bindkey "^[[3~"

# History.
HISTFILE=~/.zsh_history
HISTSIZE=10000000  # 10^7
SAVEHIST=10000000
setopt APPEND_HISTORY     # append hist after each session
setopt EXTENDED_HISTORY   # save timestamp
setopt HIST_REDUCE_BLANKS # dont save blanks


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [[ "$(uname -s)" == "Darwin" ]]; then
  export PATH="/usr/local/opt/node@10/bin:$PATH"
fi
