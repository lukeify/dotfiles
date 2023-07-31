# As we use `oh-my-zsh` as a framework, much of the configuration we would otherwise set for a vanilla zsh
# installation is automatically provided. For posterity, this in the section below. Remaining customizations
# are additionally set beneath this section.
#
# -----------------------------------------------------------------------------------------------------------
# HANDLED BY OH-MY-ZSH CONFIGURATION
# -----------------------------------------------------------------------------------------------------------
#
# Terminal prompt. This variable, `PROMPT`` is an alias of `PS1`, and defines how the terminal prompt string
# should be displayed. With `zsh` percent expansion of of prompt sequences is allowed, and is documented in:
#
# https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html
#
# In this case, the output will be similar to:
#
# luke@LukesiMac ~ %
#
# An explanation:
#
# %F is the "start color", and %f is the "stop color". Immediately preceding the start color control sequence,
# the ANSI terminal colour is printed within curly braces. This is used to set the computer and username to 
# blue, and the pwd to green.
#
# %B that precedes the pwd indicates to set the text to be bold, likewise, %b is the end delimiter to disable
# bold text output.
#
# For the computer name, we have `%n`` ($USERNAME) the `@` literal, and then `%m` (The full machine hostname
# up to the first `.`).
# PROMPT="%F{blue}%n@%m%f %B%F{green}%1~%f%b %# "
#
# zsh options
# If the command typed is not recognised, but is the name of a directory in the current working directory,
# jump to it. https://zsh.sourceforge.io/Doc/Release/Options.html
# setopt -o AUTO_CD
#
# Change directory shortcuts
# alias ..='cd ..'
#
# Ruby
# alias be='bundle exec'
#
# -----------------------------------------------------------------------------------------------------------
# REMAINING CONFIGURATION 
# -----------------------------------------------------------------------------------------------------------
# Change directory shortcuts
alias dev='cd ~/Developer'
alias docs='cd ~/Documents'

# Docker compose
alias dc='docker compose'
alias dcu='dc up -d'
alias dcx='dc exec -it'
alias dcd='dc down'

# https://github.com/rbenv/rbenv
# Looks for .ruby-version and and sets your system's version for that directory to the version specified.
eval "$(rbenv init - zsh)"

# https://github.com/nvbn/thefuck
# Allows for minor corrections in spelling for console commands.
eval $(thefuck --alias)

# https://github.com/direnv/direnv/tree/master
# Load environment variables from a directory's .envrc file into your shell.
eval "$(direnv hook zsh)"

# Define the default editor for the terminal to be vim. This shell configuration is taken from
# https://unix.stackexchange.com/questions/73484
export VISUAL=vim
export EDITOR="$VISUAL"

# Define an `ll` command to be `ls` with the `l` (List files in long format), `G` (Enable colorized output), 
# and `a` (Include directories whose names begin with a dot) options enabled.
alias ll='ls -lGa'

# Startup
neofetch
