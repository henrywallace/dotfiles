alias brc='vim ~/.bashrc'
alias vrc='vim ~/.vimrc'
alias rld='source ~/.bashrc'

alias init='cd ~/init'

alias c='clear'
alias j='jobs -l'
alias less='less -gSN'

alias l='ls -G'
alias ll='ls -Glh'

alias k='kubectl'
alias ta='tmux attach'

alias v=vim
alias e='emacs -nw'
alias emacs='emacs -nw'

# allow watching aliases: https://unix.stackexchange.com/a/25329/162041
alias watch='watch '

# go
alias gp='cd $GOPATH'
alias goi='go install -v $(glide novendor)'
alias got='go test $(glide novendor)'

# git
alias g='git'
alias gb='git branch -vv'
alias gd='cdiff -s -w 100'
alias gs='git status -s'
# pretty log commits on branch only: https://stackoverflow.com/a/7415282/2601179
alias lg='source ~/.githelpers && pretty_git_log --first-parent --no-merges'
# pretty log most recent 30 commits
alias llg='source ~/.githelpers && pretty_git_log -30'

