GIT_PS1_SHOWDIRTYSTATE="yes"
GIT_PS1_SHOWSTASHSTATE="yes"
GIT_PS1_SHOWUPSTREAM="verbose"
source ~/.git-prompt.sh
source ~/.git-completion.sh

PROMPT_COMMAND=__prompt_command
__prompt_command() {
  local status="$?"
  local git="\e[1;32m$(__git_ps1)\e[0m"
  local dir="\e[1m[ $(pwd) ]\e[0m"
  if [[ ! -z $VIRTUAL_ENV ]]; then
    local venv="\e[1;36m($(basename $VIRTUAL_ENV))\e[0m"
  else
    local venv=''
  fi
  PS1="$dir $git $venv $status\n$ "
  # shopt -s extdebug
  # trap "tput sgr0" DEBUG
}

# pretty ls colors
export LSCOLORS=ExFxBxDxCxegedabagacad

#
export PATH="$HOME/bin:$HOME/.cask/bin:$PATH"

shopt -s histappend                      # append to history, don't overwrite it
export HISTFILESIZE=1000000              # big big history
export HISTSIZE=1000000                  # big big history
export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTIGNORE='ls:bg:fg'             # don't add simple commands to history
export HISTTIMEFORMAT='%F %T '           # add timestamps to history
shopt -s cmdhist

# go path
export GOPATH=$HOME/go
PATH=$GOPATH/bin:$PATH

if [ -z "$SSH_AUTH_SOCK" ]; then
  eval $(ssh-agent -s)
  ssh-add
fi

source ~/.bash_aliases
source ~/.hub-completion.sh

source /usr/local/google-cloud-sdk/completion.bash.inc
source /usr/local/google-cloud-sdk/path.bash.inc

export FZF_DEFAULT_OPTS='--height 6 --reverse'
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
