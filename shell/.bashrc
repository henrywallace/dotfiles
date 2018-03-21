#!/bin/bash
#
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
#
# This bashrc configuration was written only to work on OSX.
# TODO: make this flexible enough to work on all *nix.

# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return;;
esac

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
	xterm-color) color_prompt=yes;;
esac

# Add an "alert" alias for long running commands, e.g. `sleep 10; alert`
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# git prompt
GIT_PS1_SHOWDIRTYSTATE="yes"
#GIT_PS1_SHOWSTASHSTATE="yes"
GIT_PS1_SHOWUPSTREAM="verbose"
GIT_PROMPT=~/.git-prompt.sh
test -f $GIT_PROMPT || curl -sS -o $GIT_PROMPT https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
source $GIT_PROMPT

# git completion
GIT_COMPLETION=~/.git-completion.sh
test -f $GIT_COMPLETION || curl -sS -o $GIT_COMPLETION https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
source $GIT_COMPLETION

# because colors are awesome
source ~/.colors

# PS2 controls the prefix that the terminal prints after typing \-return. By
# default it's "> ". We change it to just 2 spaces, so that after copying it,
# pasting it would be a valid entry into a terminal.
PS2=" "

# PS4 controls the prefix for running shell scripts in debug mode, i.e. `set
# -x`. We add the script name and line number for more clarity, instead of the
# default "++ "
PS4="$0:$LINENO: "

function now_ns {
  if [ "$(uname -s)" == "Darwin" ]; then
   /usr/local/opt/coreutils/libexec/gnubin/date +%s%N
  else
   date +%s%N
  fi
}

function timer_start {
  timer_start=${timer_start:-"$(now_ns)"}
}

function timer_stop {
  local delta_ns=$((($(now_ns) - $timer_start)))
  since="$delta_ns"
  unset timer_start
}

# Nice prompt ^_^
# https://unix.stackexchange.com/a/275016/162041
# https://wiki.archlinux.org/index.php/Bash/Prompt_customization
__prompt_command() {
  local EXIT="$?"

  # Display how long previous command took if it took than 1 second. We do this
  # as close to capturing the true exit code as possible, so to be as true to
  # the time as possible.
  timer_stop
  if command -v mp &> /dev/null; then
    if [ "$since" -ge "1000000000" ]; then
      dur="$CYAN$BOLD[$(mp durfmt ${since}ns)]$NC"
    else
      dur=""
    fi
  fi

  # The previous exit code.
  if [ "$EXIT" == "0" ]; then
    status="$GREEN$BOLD$EXIT$NC"
  else
    status="${RED}${BOLD}$EXIT${NC}"
  fi

  # The current directory
  # trim whitespace: https://stackoverflow.com/a/12973694
  dir="$BOLD$(sed "s:\([^/\.]\)[^/]*/:\1/:g" <<< ${PWD/#$HOME/\~})$NC"

  # Python
  venv="$(echo $(basename $VIRTUAL_ENV 2> /dev/null || echo) | xargs)"
  if [ ! -z "$venv" ]; then
    venv="$GREEN$BOLD[$venv]$NC"
  fi
  prefix="$CYAN$(hostname -s)$NC"

  # Git
  git="$(__git_ps1 "$BLUE$BOLD[%s]$NC")"
  # stash count
  if ! git rev-parse --is-inside-work-tree &> /dev/null; then
      nstash=""
  else
    nstash="$(git stash list | wc -l | xargs)"
    if [ -z "$(echo $nstash | xargs)" ]; then
	nstash="0"
    fi
  fi
  # num commits in branch
  commits="$(git rev-list --count HEAD 2> /dev/null || echo NOGIT)"
  if [ "$commits" == "NOGIT" ]; then
    ncommit=""
  else
      ncommit="$(git log --oneline master..HEAD | wc -l | xargs)"
  fi

  # Stats

  if [ -z "$ncommit" ]; then
    stats="[$status]"
  else
    stats="[$CYAN$ncommit$NC $CYAN$nstash$NC $status]"
  fi

  PS1="${dur}${venv}${git}${stats}[$prefix $dir]\n$ "

  # At one point, in time, I thought colorizing the typed command was
  # cool:
  #
  # shopt -s extdebug
  # trap "tput sgr0" DEBUG
}
trap 'timer_start' DEBUG
PROMPT_COMMAND=__prompt_command

# pretty ls colors
# https://apple.stackexchange.com/a/33679/192291
export CLICOLOR=1

# add brew installed binaries to path
export PATH="$HOME/bin:$HOME/.cask/bin:$PATH"

# https://unix.stackexchange.com/a/18443/162041
# https://www.gnu.org/software/bash/manual/html_node/Bash-Variables.html
export HISTFILESIZE=10000000    # history 10^7
export HISTSIZE=10000000        # history 10^7
export HISTTIMEFORMAT='%F %T '  # add timestamps to history
HISTCONTROL=ignoredups
shopt -s histappend cmdhist

# emacs daemon
# https://stackoverflow.com/a/5578718
export ALTERNATE_EDITOR=""

# golang
export GOPATH=$HOME/go
PATH=$GOPATH/bin:$PATH

# rustlang
PATH="$HOME/.cargo/bin:$PATH"

# Start ssh-agent if not running: https://unix.stackexchange.com/a/90869/162041
if [ -z "$SSH_AUTH_SOCK" ]; then
  eval $(ssh-agent -s)
  ssh-add
fi

# Standard aliases
source ~/.aliases

# GCP
# TODO: add auto-downloads for this:
if [ "$(uname -s)" == "Linux" ]; then
  GCLOUD=/usr/share/google-cloud-sdk
else
  GCLOUD=/usr/local
fi
if [ -f "$GCLOUD/path.bash.inc" ]; then source "$GCLOUD/path.bash.inc"; fi
if [ -f "$GCLOUD/completion.bash.inc" ]; then source "$GCLOUD/completion.bash.inc"; fi


# fzf fuzzy searching
FZF_SH=~/.fzf.sh
test -f $FZF_SH || curl -sS -o $FZF_SH https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.bash
source $FZF_SH
export FZF_DEFAULT_OPTS='--height 6 --reverse'

# Makefile completion: https://stackoverflow.com/a/36044470/2601179
function _makefile_targets {
    local curr_arg;
    local targets;
    # find makefile targets available in the current directory
    targets=''
    if [[ -e "$(pwd)/Makefile" ]]; then
        targets=$( \
            grep -oE '^[a-zA-Z0-9_-]+:' Makefile \
            | sed 's/://' \
            | tr '\n' ' ' \
        )
    fi
    # filter targets based on user input to the bash completion
    curr_arg=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $(compgen -W "${targets[@]}" -- $curr_arg ) );
}
complete -F _makefile_targets make

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
    shopt -s "$option" 2> /dev/null
done

# Add tab completion for SSH hostnames based on ~/.ssh/config
# ignoring wildcards
[[ -e "$HOME/.ssh/config" ]] && complete -o "default" \
	-o "nospace" \
	-W "$(grep "^Host" ~/.ssh/config | \
	grep -v "[?*]" | cut -d " " -f2 | \
	tr ' ' '\n')" scp sftp ssh

# Cowthink
animals="
bud-frogs
default
elephant
flaming-sheep
kitty
koala
moofasa
moose
satanic
sheep
skeleton
small
three-eyes
tux
udder
vader
$HOME/.misc/hypno.cow
"
animal="$(echo "$animals" | sed '/^$/d' | sort -R | head -1)"
method="$(echo cowthink cowsay | xargs | tr ' ' '\n' | sort -R | head -1)"
# Only display cowthink every other login.
if [ "$(shuf -i1-2 -n1)" -le "1" ]; then
  $method -f $animal $(fortune -s)
fi

complete -C /usr/local/bin/vault vault
