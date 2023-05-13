# Dotfiles

✨ Stuff I need to do all the things ✨

```zsh
git clone git@github.com:lukeify/dotfiles.git
cd dotfiles
./dotfiles.sh
```

## Running

`./dotfiles.sh` expects that arguments will be provided to determine which aspects of the system should be configured. This explicitly requires you to read the documentation under `./dotfiles.sh --help` to gain an understanding of the implications of each aspect to be configured. These aspects can be enabled with the following flags:

1. `APPS=1` will install brew, associated apps, packages, and casks.
2. `DEFAULTS=1` will set system-wide defaults using `defaults write`.
3. `DOCK=1` will configure the dock using `dockutil`.
4. `TEXT_REPLACEMENTS=1` will generate a `Text Substitutions.plist` file that can be manully dropped into the `Settings.app` > _Keyboard_ > _Text_ pane.

## Useful resources

Thanks to the following people for inspiration and configuration ideas:

- [mathiabynens][1], for everyone's favourite dotfiles repository.
- [carrlos0][3]

## Notes

### Text replacements errata

Text replacements in macOS are backed by CloudKit and synced across your iCloud account. These are written out to `NSGlobalDomain` under preference `NSUserDictionaryReplacementItems`; however CloudKit will not sync any changes you make to this preference, instead, you must write a row to the `ZTEXTREPLACEMENTSENTRY` table in the `~/Library/KeyboardServices/TextReplacements.db` SQLite database, setting `ZNEEDSSAVETOCLOUD` to `1`, while also defining the `ZPHRASE` and `ZSHORTCUT`.

These changes are not synced to iCloud immediately and may require a system restart.

### Todos

- Implement both `Terminal.app` and `iTerm2.app` themes.
- Create application shortcut adjustements.
- Properly implement text replacements.
- Configure the Finder sidebar.
- Configure Transmission properly.
- Set the desktop background, even.
- Configure `pmset`.
- Remove prerequisites for both `yarn` and `node` existing on the system to run `dotfiles.sh`.
- Try to follow the patterns set out by [dotfiles.github.io][2].

[1]: https://github.com/mathiasbynens/dotfiles
[2]: https://dotfiles.github.io
[3]: https://github.com/caarlos0/dotfiles/blob/master/macos/set-defaults.sh
[4]: https://eclecticlight.co/2019/08/22/working-safely-and-effectively-with-preferences-in-mojave/
