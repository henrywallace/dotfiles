# config
alias ba='emacs ~/.bash_aliases'
alias brc='emacs ~/.bashrc'
alias el='emacs ~/.emacs.el'
alias rld='source ~/.bashrc'
alias vrc='vim ~/.vimrc'

# misc
alias init='cd ~/init'
alias k='kubectl'
alias rg='rg -M100 --colors path:fg:green --colors path:style:bold --colors line:fg:blue --colors line:style:bold'
alias rgo="rg -g '*.go'"
alias ta='tmux attach'
alias watch='watch --color ' # https://unix.stackexchange.com/a/25329/162041

# generic *nix
alias c='clear'
alias j='jobs -l'
alias less='less -gS'
alias le='less'
alias ls='exa --group-directories-first'
alias l='ls'
alias ll='ls -la'

# editors
alias e='emacs'
alias emacs='emacs -nw'
alias v=vim

# golang
alias goi='go install -v ./...'

# rustlang
alias cup='cargo install-update -a'

# git
alias conflicts="rg '<<<<<<<'"
alias dif='git diff master..HEAD --stat'
alias g='git'
alias gb='git branch -vv'
alias gd='git diff'
alias gs='git status'
alias lg='git log --oneline master..HEAD'
alias llg='git log --graph --oneline'
alias lr='git show HEAD'
alias rb='git rebase -i master'
alias rc='git rebase --continue'
alias review='git log --stat --reverse master..HEAD'
alias st='git stash show -p'
