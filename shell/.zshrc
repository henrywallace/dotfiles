# Base shell-agnostic rc.
. ~/.corerc

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
# https://github.com/sindresorhus/pure

# https://github.com/zsh-users/zsh-autosuggestions#key-bindings
bindkey '^ ' autosuggest-accept

# https://vi.stackexchange.com/a/10142
set formatoptions+=r
# set comments-=mb:*
# set comments+=fb:*

. ~/.zsh/prompt/prompt.zsh
AGKOZAK_COLORS_USER_HOST=cyan
AGKOZAK_COLORS_PATH=black
AGKOZAK_COLORS_BRANCH_STATUS=black
AGKOZAK_PROMPT_DIRTRIM=3

# Don't add anything to $PATH if it's there already.
# https://wiki.archlinux.org/index.php/zsh
# https://stackoverflow.com/a/13060074/2601179
typeset -gU path

# Enable autocompletion of privileged environments in privileged commands, e.g.
# sudo prefixed.
zstyle ':completion::complete:*' gain-privileges 1

# # Fish-like syntax hlghlighting.
# # https://github.com/zsh-users/zsh-syntax-highlighting
ZSH_SYNTAX_HIGHLIGHTING=~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
if [[ -f "$ZSH_SYNTAX_HIGHLIGHTING" ]]; then
  . "$ZSH_SYNTAX_HIGHLIGHTING"
fi

ZSH_AUTOSUGGESTIONS=~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
if [[ -f "$ZSH_AUTOSUGGESTIONS" ]]; then
  . "$ZSH_AUTOSUGGESTIONS"
fi

# Use emacs mode.
bindkey -e

# History.
HISTFILE=~/.zsh_history
HISTSIZE=10000000  # 10^7
SAVEHIST=10000000
setopt APPEND_HISTORY     # append hist after each session
setopt EXTENDED_HISTORY   # save timestamp
setopt HIST_REDUCE_BLANKS # dont save blanks


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
