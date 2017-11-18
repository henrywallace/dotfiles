# git prompt
GIT_PS1_SHOWDIRTYSTATE="yes"
GIT_PS1_SHOWSTASHSTATE="yes"
GIT_PS1_SHOWUPSTREAM="verbose"
GIT_PROMPT=~/.git-prompt.sh
test -f $GIT_PROMPT || curl -sS -o $GIT_PROMPT https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
source $GIT_PROMPT

# git completion
GIT_COMPLETION=~/.git-completion.sh
test -f $GIT_COMPLETION || curl -sS -o $GIT_COMPLETION https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
source $GIT_COMPLETION

# nice prompt
# https://unix.stackexchange.com/a/275016/162041
# https://wiki.archlinux.org/index.php/Bash/Prompt_customization
PROMPT_COMMAND=__prompt_command
__prompt_command() {
  local status="$?"
  local git="\e[1;32m$(__git_ps1)\e[0m"
  local dir="\e[1m$(sed "s:\([^/\.]\)[^/]*/:\1/:g" <<< ${PWD/#$HOME/\~})\e[0m"
  if [[ ! -z $VIRTUAL_ENV ]]; then
    local venv="\e[1;36m($(basename $VIRTUAL_ENV))\e[0m"
  else
    local venv=''
  fi
  # PS1="$status $venv $git $dir\n$ "
  local prefix="$(whoami)@$(hostname):"
  local stash="$(test -d .git && git stash list | echo $(wc -l) || echo)"
  PS1="$prefix$dir $venv $git $stash\n$ "
  # shopt -s extdebug
  # trap "tput sgr0" DEBUG
}

# pretty ls colors
# https://apple.stackexchange.com/a/33679/192291
export CLICOLOR=1

# add brew installed binaries to path
export PATH="$HOME/bin:$HOME/.cask/bin:$PATH"

# https://unix.stackexchange.com/a/18443/162041
# https://www.gnu.org/software/bash/manual/html_node/Bash-Variables.html
export HISTFILESIZE=10000000             # big big history
export HISTSIZE=10000000                 # big big history
export HISTTIMEFORMAT='%F %T '           # add timestamps to history
HISTCONTROL=ignoredups
shopt -s histappend cmdhist


# go path
export GOPATH=$HOME/go
PATH=$GOPATH/bin:$PATH

# start ssh-agent if not running: https://unix.stackexchange.com/a/90869/162041
if [ -z "$SSH_AUTH_SOCK" ]; then
  eval $(ssh-agent -s)
  ssh-add
fi

# standard aliases
source ~/.bash_aliases

# gcp
source /usr/local/google-cloud-sdk/completion.bash.inc
source /usr/local/google-cloud-sdk/path.bash.inc

# fzf fuzzy searching
export FZF_DEFAULT_OPTS='--height 6 --reverse'
source ~/.fzf.bash

# Makefile completion: https://stackoverflow.com/a/36044470/2601179
function _makefile_targets {
    local curr_arg;
    local targets;

    # Find makefile targets available in the current directory
    targets=''
    if [[ -e "$(pwd)/Makefile" ]]; then
        targets=$( \
            grep -oE '^[a-zA-Z0-9_-]+:' Makefile \
            | sed 's/://' \
            | tr '\n' ' ' \
        )
    fi

    # Filter targets based on user input to the bash completion
    curr_arg=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $(compgen -W "${targets[@]}" -- $curr_arg ) );
}
complete -F _makefile_targets make
