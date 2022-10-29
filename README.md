# Dotfiles

✨ Stuff I need to do all the things ✨

```zsh
git clone git@github.com:lukeify/dotfiles.git
cd dotfiles
./dotfiles.sh
```

## Running

You can run `./dotfiles.sh` with no arguments provided to configure the system in its entirety, or alternatively, you can pass any of the following environment args to customise
what should be run:

1. `DOCK=1` will configure the dock using `dockutil`.
2. `DEFAULTS=1` will set system-wide defaults using `defaults write`.
3. `BREW=1` will install brew, and associated packages & casks.
4. `TEXT_REPLACEMENTS=1` will generate the `Text Substitutions.plist` file that can be dropped into _System Preferences_ > _Keyboard_ > _Text_.

Run `./dotfiles.sh --help` for more info.

## Useful resources

Thanks to the following people for inspiration and configuration ideas:

- [mathiabynens][1], for everyone's favourite dotfiles repository.
- [carrlos0][3]

Additionally, this repository tries to follow the patterns set out by [dotfiles.github.io][2].

### Text replacements errata

Text replacements in macOS are backed by CloudKit and synced across your iCloud account. These are written out to `NSGlobalDomain` under preference `NSUserDictionaryReplacementItems`; however CloudKit will not sync any changes you make to this preference, instead, you must write a row to the `ZTEXTREPLACEMENTSENTRY` table in the `~/Library/KeyboardServices/TextReplacements.db` SQLite database, setting `ZNEEDSSAVETOCLOUD` to `1`, while also defining the `ZPHRASE` and `ZSHORTCUT`.

These changes are not synced to iCloud immediately and may require a system restart.

## Todos

_One thing removed is two more things added._

- Implement both Terminal.app and iTerm.app themes.
- Create application shortcut adjustements.
- Properly implement text replacements.
- Configure the Finder sidebar.
- Configure Transmission properly.
- Set the desktop background, even.
- Configure pmset.

[1]: https://github.com/mathiasbynens/dotfiles
[2]: https://dotfiles.github.io
[3]: https://github.com/caarlos0/dotfiles/blob/master/macos/set-defaults.sh
[4]: https://eclecticlight.co/2019/08/22/working-safely-and-effectively-with-preferences-in-mojave/
