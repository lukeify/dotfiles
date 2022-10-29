# Terminal prompt
PROMPT="%F{blue}%n@%m%f %B%F{green}%1~%f%b %# "

# zsh options
# If the command typed is not recognised, but is the name of a directory in the current working directory,
# jump to it. https://zsh.sourceforge.io/Doc/Release/Options.html
setopt -o AUTO_CD

# General
export editor=vim
alias ll='ls -lGa'
alias ..='cd ..'
eval $(thefuck --alias)

# Work
alias proj='cd ~/Projects'

# Docker stuff
alias dc='docker compose'
alias dcu='dc up -d'
alias dcx='dc exec -it'
alias dcd='dc down'

# Ruby stuff
alias be='bundle exec'
eval "$(rbenv init - zsh)"
eval "$(direnv hook zsh)"

# Startup
neofetch