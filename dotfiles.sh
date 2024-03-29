#!/usr/bin/env bash

# Descriptions for each of these options can be found here:
# https://elder.dev/posts/safer-bash/#enable-error-handling-options
set -o errexit
set -o nounset
set -o pipefail

# If the first argument passed is "--help", print out the manual information about the command.
# This should be migrated to a `man` command at some point in the future.
if [[ "${1-}" = "--help" ]]; then
    echo "Usage: ./dotfiles.sh

Hello! You're one step closer to having a consistent macOS experience!
This script will only execute the sections you intend to enable. These are:

    - Installing brew, along with apps, packages, and casks. (APPS=1)
    - Organising your macOS dock with \`dockutil\`. (DOCK=1)
    - Setting macOS defaults with \`defaults\`. (DEFAULTS=1)
    - Copy over home user configuration into \`~\`. (HOME=1)
    - Creating a text replacements plist for you to drag into Settings.app. (TEXT_REPLACEMENTS=1)

If you'd like to only do some of these things, pass some of the flags above
as arguments set to 1. An example of this alternative usage is provided below:

  # Only configure the dock
  DOCK=1 ./dotfiles.sh

  # Install brew packages & apps and configure defaults
  APPS=1 DEFAULTS=1 ./dotfiles.sh

Some functionality requires Node & Yarn. If this functionality is required, then \`APPS=1\` will 
be executed automatically.
";
exit 0
fi

# Define each of the flag that this script accepts, setting the value to zero if none is provided.
APPS="${APPS:-0}"
DOCK="${DOCK:-0}"
DEFAULTS="${DEFAULTS:-0}"
HOME="${HOME:-0}"
TEXT_REPLACEMENTS="${TEXT_REPLACEMENTS:-0}"

# Determine if compilation of the typescript functionality included in this repository is required. 
# This is needed for any functionality that runs via node.js.
requires_compilation() {
    [ "$DOCK" = 1 ] || [ "$DEFAULTS" = 1 ] || [ "$TEXT_REPLACEMENTS" = 1 ];
}

# Determines if the provided aspect of the dotfiles script should be executed, by checking if its value
# has been set to `1`.
should_run() {
    [ "$1" = 1 ];
}

# Setup brew and install the contents of `Brewfile`, including casks, and `mas` entries.
run_apps() {
    if [[ ! $(which -s brew) ]] ; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        brew update
    fi
    brew bundle
}

if requires_compilation; then
    run_apps
    yarn run compile > /dev/null 2>&1
fi

# ------------------------------------------------------------------------------------------
# APPS
# Install applications. If other setup steps require Node, then this will run regardless.
# ------------------------------------------------------------------------------------------
if should_run "$APPS" && ! requires_compilation; then
    run_apps
fi 

# ------------------------------------------------------------------------------------------
# DOCK
# Configure the macOS dock.
# ------------------------------------------------------------------------------------------
if should_run "$DOCK"; then
    node ./dist/dock.js
fi

# ------------------------------------------------------------------------------------------
# DEFAULTS
# Update default preferences across macOS to make the OS more homely.
# ------------------------------------------------------------------------------------------
if should_run "$DEFAULTS"; then
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

# ------------------------------------------------------------------------------------------
# HOME
# Configure the home directory and other personalisations for the user. This currently includes `zsh` shell configuration.
# ------------------------------------------------------------------------------------------
if should_run "$HOME"; then
    # Install ohmyzsh and append on our additional zsh configuration.
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    cat .zshrc >> ~/.zshrc
fi

# ------------------------------------------------------------------------------------------
# TEXT_REPLACEMENTS
# Generate text replacements output.
# ------------------------------------------------------------------------------------------
if should_run "$TEXT_REPLACEMENTS"; then
    node ./dist/textreplacements.js
    echo "
Generated 'Text Substitutions.plist'! Drag this file into the table view of
System Settings.app > Keyboard > Text.
";
fi 

if requires_compilation; then
    rm -rf ./dist
fi
