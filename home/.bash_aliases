alias brc='vim ~/.bashrc'
alias vrc='vim ~/.vimrc'
alias rld='source ~/.bashrc'

alias init='cd ~/init'

alias c='clear'
alias j='jobs -l'
alias less='less -gSN'
alias le='less'

alias ls='exa --group-directories-first'
alias l='exa --group-directories-first'
alias ll='exa -la --group-directories-first'

alias k='kubectl'
alias ta='tmux attach'

alias v=vim
alias e='emacs -nw'
alias emacs='emacs -nw'

# allow watching aliases: https://unix.stackexchange.com/a/25329/162041
alias watch='watch --color '

# go
alias gp='cd $GOPATH'
alias goi='go install -v $(glide novendor)'
alias got='go test $(glide novendor)'
alias rg='rg -M100'
alias gr="rg -g '*.go'"

# git
alias g='git'
alias gb='git branch -vv'
alias gd='cdiff -s -w 100'
alias gs='git status'
alias lr='git show HEAD'
alias lg='git log --oneline master..HEAD'
alias llg='git log --graph --oneline'
alias rc='git rebase --continue'
alias rb='git rebase -i master'
alias dif='git diff master..HEAD --stat'
alias conflicts="rg '<<<<<<<'"
alias st='git stash list -p'
alias review='git log --stat --reverse master..HEAD'
