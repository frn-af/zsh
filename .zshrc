# User aliases and configurations
# Note: Plugin loading is handled by Zinit in plugin.zsh
# Note: Common aliases (c, ls, .., etc.) are defined in terminal.zsh

# Enable auto-cd (type directory name to cd into it)
setopt AUTO_CD

# Git aliases
alias g='git'

# everyday workflow
alias gs='git status'           # repo state
alias ga='git add'              # stage changes
alias gc='git commit -m'        # commit with message
alias gca='git commit -am'      # stage & commit in one

# branching / navigation
alias gco='git checkout'        # switch branch or file
alias gcb='git checkout -b'     # new branch & switch
alias gb='git branch'           # list branches

# syncing with remote
alias gl='git pull --rebase'    # fast-forward local branch
alias gp='git push'             # upload commits

# reviewing & history
alias gd='git diff'             # view local changes
alias glg='git log --oneline --graph --decorate'  # compact history

# stashing
alias gst='git stash'           # save WIP
alias gsp='git stash pop'       # restore WIP

# cloning
alias gcl='git clone'           # clone remote repository

#lazygit
alias lg='lazygit'

# User configuration
export EDITOR=agy


# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "/Users/frnaf/.bun/_bun" ] && source "/Users/frnaf/.bun/_bun"
