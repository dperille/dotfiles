alias gs="git status"
alias gb="git branch"
alias gd="git diff"
alias gcm="git commit -m"
alias gch="git checkout"

PROMPT='%(?.%F{green}✓.%F{red}?%?)%f %B%F{243}%2~%f%b %# '

# Vi-style editing in terminal
bindkey -v

export GOPATH=$HOME/go
export PATH="/opt/homebrew/bin:$PATH:$GOPATH/bin"

