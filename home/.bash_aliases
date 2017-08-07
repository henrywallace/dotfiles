alias brc='vim ~/.bashrc'
alias c='clear'
alias emacs='emacs -nw'
alias j='jobs -l'
alias julia='exec /Applications/Julia-0.3.10.app/Contents/Resources/julia/bin/julia'
alias k='kubectl'
alias l='ls'
alias ll='ls -lh'
alias ls='ls -G'
alias rld='source ~/.bashrc'
alias ta='tmux attach'
alias v=vim
alias vrc='vim ~/.vimrc'

# allow watching aliases: https://unix.stackexchange.com/a/25329/162041
alias watch='watch '

# go
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

