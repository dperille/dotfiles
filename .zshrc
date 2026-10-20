alias gb="git branch"
alias gch="git checkout"
alias gcm="git commit -m"
alias gd="git diff"
alias gds="git diff --staged"
alias gr="git restore"
alias grs="git restore --staged"
alias gs="git status"

PROMPT='%(?.%F{green}✓.%F{red}?%?)%f %B%F{243}%2~%f%b %# '

# Vi-style editing in terminal
bindkey -v

export GOPATH=$HOME/go
export PATH="/opt/homebrew/bin:$PATH:$GOPATH/bin"

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/dotfiles/bin:$PATH"

# Source machine-specific .zshrc.local, if it exists
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
