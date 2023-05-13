#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

if [[ "${1-}" = "--help" ]]; then
    echo "Usage: ./dotfiles.sh

Hello! You're one step closer to having a consistent macOS experience!    
By default, dotfiles will run a full system configuration. This includes:

    - Installing brew, along with packages and casks. (BREW=1)
    - Organising your macOS dock. (DOCK=1)
    - Setting macOS defaults with dockutil. (DEFAULTS=1)
    - Creating a text replacements plist for you to drag into System Preferences. (TEXT_REPLACEMENTS=1)

If you'd like to only do some of these things, pass some of the flags above
as arguments set to 1. An example of this alternative usage is provided below:

  # Only configure the dock
  DOCK=1 ./dotfiles.sh

  # Install brew packages and configure defaults
  BREW=1 DEFAULTS=1 ./dotfiles.sh
";
exit 0
fi

# Assign default values to unassigned arguments.
BREW="${BREW:-0}"
DOCK="${DOCK:-0}"
DEFAULTS="${DEFAULTS:-0}"
TEXT_REPLACEMENTS="${TEXT_REPLACEMENTS:-0}"

if [[ "$BREW" = 0 && "$DOCK" = 0 && "$DEFAULTS" = 0 && "$TEXT_REPLACEMENTS" = 0 ]] ; then
    ALL=1
else
    ALL=0
fi

# Determine if compilation of the typescript functionality included in this
# repository is required.
requires_js_compilation() {
    [ "$ALL" = 1 ] || [ "$DOCK" = 1 ] || [ "$DEFAULTS" = 1 ] || [ "$TEXT_REPLACEMENTS" = 1 ];
}

# Determines if the provided aspect should be executed by the script.
aspect_should_run() {
    [ "$ALL" = 1 ] || [ "$1" = 1 ];
}

if requires_js_compilation; then
    yarn run compile > /dev/null 2>&1
fi

# Where it all begins. Setup brew and install the contents of `Brewfile`.
if aspect_should_run "$BREW"; then
    if [[ ! $(which -s brew) ]] ; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        brew update
    fi
    brew bundle
fi 

# Configure the macOS dock. This requires node, and as such also requires
# the brew profile to have been executed. 
if aspect_should_run "$DOCK"; then
    node ./dist/dock.js
fi

# Update default preferences across macOS to make the OS more homely.
if aspect_should_run "$DEFAULTS"; then
    node ./dist/desktop.js
    node ./dist/finder.js
    node ./dist/global.js
    node ./dist/launchpad.js
    node ./dist/mail.js
    node ./dist/misc.js
    node ./dist/safari.js

    # Produces a whitespace free string, i.e. "iMac" or "MacBookPro"
    DEVICE_TYPE="$(system_profiler SPHardwareDataType | awk -F ':' '/Model Name/ {print $2}' | awk '{ gsub(" ", "", $0); print}')"
    sudo scutil --set ComputerName "Lukes$DEVICE_TYPE"
    sudo scutil --set HostName "Lukes$DEVICE_TYPE"
    sudo scutil --set LocalHostName "Lukes$DEVICE_TYPE"
fi

if aspect_should_run "$TEXT_REPLACEMENTS"; then
    node ./dist/textreplacements.js
    echo "
Generated 'Text Substitutions.plist'! Drag this file into the table view of
System Preferences > Keyboard > Text.
";
fi 

if requires_js_compilation; then
    rm -rf ./dist
fi

# iTerm configuration. `lukeify.itermcolors` is a slightly modified 
# color theme that is based off `iceberg-dark`.
# cp iterm2/lukeify.itermcolors ~/.config/iterm2/lukeify.itermcolors

# Setup neofetch
# cp neofetch.config ~/.config/neofetch/config.conf

# Configure our shell
# touch ~/.hushlogin
# cp .zshrc ~/.zshrc

# TODO: 
# #cp .ssh/config ~/.ssh/config
# #cp .gitconfig ~/.gitconfig