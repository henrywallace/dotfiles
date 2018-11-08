#!/bin/bash

# If not running interactively, don't do anything. Why is this necessary? While
# bash shells normally don't run ~/.bashrc at start-up, there's an exception
# for remote shell daemons. In those circumstances, printing anything is
# considered harmful. See: https://unix.stackexchange.com/a/257613/162041
case $- in
  *i*) ;;
  *) return;;
esac

# Check the window size after each command and, if necessary, update the values
# of LINES and COLUMNS.
shopt -s checkwinsize

# Add an "alert" alias for long running commands, e.g. `sleep 10; alert`
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# git prompt
export GIT_PS1_SHOWDIRTYSTATE="yes"
export GIT_PS1_SHOWUPSTREAM="verbose"
export GIT_PROMPT=~/.git-prompt.sh
test -f $GIT_PROMPT || curl -o $GIT_PROMPT https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
source $GIT_PROMPT

# git completion
GIT_COMPLETION=~/.git-completion.sh
test -f $GIT_COMPLETION || curl -o $GIT_COMPLETION https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
source $GIT_COMPLETION

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
  # Nice time formatting.
  # https://github.com/henrywallace/multipurpose
  local DUR
  if command -v mp &> /dev/null; then
    if [ "$since" -ge "1000000000" ]; then
      DUR="$CYAN$BOLD[$(mp durfmt ${since}ns)]$NC"
    else
      DUR=""
    fi
  fi

  # The previous exit code.
  local STATUS
  if [ "$EXIT" == "0" ]; then
    STATUS="$GREEN$BOLD$EXIT$NC"
  else
    STATUS="${RED}${BOLD}$EXIT${NC}"
  fi

  # The current directory
  # trim whitespace: https://stackoverflow.com/a/12973694
  dir="$BOLD$(sed "s:\([^/\.]\)[^/]*/:\1/:g" <<< ${PWD/#$HOME/\~})$NC"

  # Python
  local VENV
  VENV="$(echo "$(basename $VIRTUAL_ENV 2> /dev/null || echo)" | xargs)"
  if [ ! -z "$VENV" ]; then
    VENV="$GREEN$BOLD[$VENV]$NC"
  fi
  prefix="$BOLD$CYAN$(hostname -s)$NC"

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
    stats=""
  else
    stats="[$BOLD$CYAN$ncommit$NC $CYAN$nstash$NC]"
  fi

  PS1="[$prefix $dir]${VENV}${git}${stats}${DUR}\n$ "

  # At one point, in time, I thought colorizing the typed command was
  # cool:
  #
  # shopt -s extdebug
  # trap "tput sgr0" DEBUG
}
trap 'timer_start' DEBUG
PROMPT_COMMAND=__prompt_command

# Pretty ls colors.
# https://apple.stackexchange.com/a/33679/192291
export CLICOLOR=1

# I'm still perplexed on how to manage bash history appropriately.
#
# https://unix.stackexchange.com/a/18443/162041
# https://www.gnu.org/software/bash/manual/html_node/Bash-Variables.html
export HISTFILESIZE=10000000    # history 10^7
export HISTSIZE=10000000        # history 10^7
export HISTTIMEFORMAT='%F %T '  # add timestamps to history
HISTCONTROL=ignoredups
shopt -s histappend cmdhist

if [ -f "$GCLOUD/completion.bash.inc" ]; then source "$GCLOUD/completion.bash.inc"; fi

# Makefile completion.
# https://stackoverflow.com/a/36044470/2601179
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

complete -C /usr/local/bin/vault vault

# Cowthink
animals="
bud-frogs
default
flaming-sheep
moofasa
satanic
sheep
skeleton
udder
$HOME/.misc/hypno.cow
"
animal="$(echo "$animals" | sed '/^$/d' | sort -R | head -1)"
method="$(echo cowthink cowsay | xargs | tr ' ' '\n' | sort -R | head -1)"
# Only display cowthink every other login.
if [ "$(shuf -i1-8 -n1)" -le "1" ]; then
  $method -f $animal $(fortune -s)
fi

