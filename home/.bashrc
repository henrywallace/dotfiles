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
#GIT_PS1_SHOWDIRTYSTATE="yes"
#GIT_PS1_SHOWSTASHSTATE="yes"
#GIT_PS1_SHOWUPSTREAM="verbose"
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

# Nice prompt ^_^
# https://unix.stackexchange.com/a/275016/162041
# https://wiki.archlinux.org/index.php/Bash/Prompt_customization
PROMPT_COMMAND=__prompt_command
__prompt_command() {
  # The previous exit code.
  if [ "$?" == "0" ]; then
    status="$?"
  else
    status="$RED$BOLD$?$NC"
  fi

  # The current directory
  # trim whitespace: https://stackoverflow.com/a/12973694
  dir="$BOLD$(sed "s:\([^/\.]\)[^/]*/:\1/:g" <<< ${PWD/#$HOME/\~})$NC"

  # Python
  venv="$(echo $(basename $VIRTUAL_ENV 2> /dev/null || echo) | xargs)"
  if [ ! -z "$venv" ]; then
    venv="$GREEN$BOLD($venv)$NC"
  fi
  prefix="$(hostname -s)"

  # Git
  git="$BLUE$BOLD$(echo $(__git_ps1) | xargs)$NC"
  # stash count
  stashes="$(git stash list 2> /dev/null || echo NOGIT)"
  if [ "$stashes" == "NOGIT" ]; then
    nstash=""
  else
    nstash="$(echo "$stashes" | xargs | wc -l | xargs)"
  fi
  # num commits in branch
  commits="$(git rev-list --count HEAD 2> /dev/null || echo NOGIT)"
  if [ "$commits" == "NOGIT" ]; then
    ncommit=""
  else
    ncommit="$(git log --oneline master..HEAD | wc -l | xargs)"
  fi

  # Stats
  stats="[$ncommit.$nstash.$status]"

  PS1="$venv$git$stats[$prefix $dir] "

  # At one point, in time, I thought colorizing the typed command was
  # cool:
  #
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
PATH=.cargo/bin:$PATH

# Start ssh-agent if not running: https://unix.stackexchange.com/a/90869/162041
if [ -z "$SSH_AUTH_SOCK" ]; then
  eval $(ssh-agent -s)
  ssh-add
fi

# Standard aliases
source ~/.aliases

# GCP
# TODO: add auto-downloads for this:
source /usr/local/google-cloud-sdk/completion.bash.inc
source /usr/local/google-cloud-sdk/path.bash.inc

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
animal="$(cowthink -l | tail -n +2 | xargs | tr ' ' '\n' | sort -R | head -1)"
method="$(echo cowthink cowsay | xargs | tr ' ' '\n' | sort -R | head -1)"
$method -f $animal $(fortune)
