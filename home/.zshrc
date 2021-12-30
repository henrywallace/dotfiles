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

fpath=( "$HOME/.zfunctions" $fpath )

# Tab complete dir colors.
# https://github.com/robbyrussell/oh-my-zsh/issues/1563#issuecomment-26591369.
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"

# Allow completing inside of words.
setopt completeinword

# Bash-style delete backword
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

gf() {
    # | awk '{printf "\033[2m%2d\033[0m %s\n", NR, $0}' \
  commit=$(git log --reverse --oneline "$(git merge-base "$(git symbolic-ref refs/remotes/origin/HEAD --short)" HEAD)"..HEAD \
    | awk '{printf "%2d %s\n", NR, $0}' \
    | tac \
    | fzf \
    | awk '{print $2}')
  zle reset-prompt
  echo git commit --fixup "$commit"
}
zle -N gf
bindkey ^F gf

# https://vi.stackexchange.com/a/10142
set formatoptions+=r
# set comments-=mb:*
# set comments+=fb:*

# prompt pure
# PURE_CMD_MAX_EXEC_TIME=2
# PURE_PROMPT_SYMBOL='%%'

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

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/ubuntu/google-cloud-sdk/path.zsh.inc' ]; then . '/home/ubuntu/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/ubuntu/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/ubuntu/google-cloud-sdk/completion.zsh.inc'; fi

# # https://zsh.sourceforge.io/Doc/Release/Command-Execution.html#Command-Execution
# command_not_found_handler() {
#   echo "Command not found: $1" | pokemonsay -n
# }
