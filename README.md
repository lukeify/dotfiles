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
4. `HOME=1` configures many services in your home directory (zsh, vim, ssh, etc).
5. `TEXT_REPLACEMENTS=1` will generate a `Text Substitutions.plist` file that can be manully dropped into the `System Settings.app` > _Keyboard_ > _Text_ pane.

## Documentation

Miscellaneous documentation for the remainder of these dotfiles is as follows.

### iTerm2 configuration

`iterm2/com.googlecode.iterm2.plist` can be exported from iTerm2 Preferences via General → Preferences, ensuring "Load preferences from a custom folder or URL" is ticked, browsing to save out preferences to this repository's location on disk, and persisting changes when your preferences change.

A collection of colours which can be imported into an iTerm profile are known as "Colour Presets" and can be exported/imported as an `itermcolors` file (seen in this repository as `item2/lukeify.itermcolors`).

An entire iTerm Profile can be composed of these presets and other appearance values, and is stored in the `iterm2/lukeify-iterm.json` file which can likewise be exported/imported from the bottom right of the profile tableview within iTerm 2 Preferences → Profiles.

#### ANSI Colour mappings

The ANSI colour mappings defined for my terminal configurations is as follows:

| Name       | Colour                                                               |
|------------|----------------------------------------------------------------------|
| Black      | `hsl(225, 10%, 15%)` (`#23252B`)                                     | 
| Red        | `hsl(351, 31%, 52%)` (`#AA5E6A`)                                     |
| Green      | `hsl(145, 43%, 50%)` (`#49B776`)                                     | 
| Yellow     | `hsl(40, 65%, 64%)` (`#DEB566`)                                      |
| Blue       | `hsl(222, 48%, 48%)` (`#3F62B5`)                                     | 
| Magenta    | `hsl(310, 19%, 56%)` (`#A4799D`)                                     | 
| Cyan       | `hsl(191, 45%, 45%)` (`#3F94A8`)                                     | 
| White      | `hsl(227, 22%, 92%)` (`#E6E8EF`)                                     |
| Background | `hsla(206, 75%, 11%, 0.8)` (`#071F31`) (with 30% blur, if supported) |
| Cursor     | `hsl(65, 41%, 95%)` (`#F6F7EC`)                                      |
| Text       | `hsl(227, 22%, 92%)` (`#E6E8EF`) (same as "White")                   |
| Bold Text  | `hsl(208, 100%, 89%)` (`#C5E4FF`)                                    | 
| Selection  | `hsl(211, 23%, 62%)` (`#889DB4`)                                     |

Unfortunately these will look different in `iTerm2.app` vs. `Terminal.app` as the former does not display P3 colour.

## Other information

### Useful resources

Thanks to the following people for inspiration and configuration ideas:

- [mathiabynens][1], for everyone's favourite dotfiles repository.
- [carrlos0][3]

### Text replacements errata

Text replacements in macOS are backed by CloudKit and synced across your iCloud account. These are written out to `NSGlobalDomain` under preference `NSUserDictionaryReplacementItems`; however CloudKit will not sync any changes you make to this preference, instead, you must write a row to the `ZTEXTREPLACEMENTSENTRY` table in the `~/Library/KeyboardServices/TextReplacements.db` SQLite database, setting `ZNEEDSSAVETOCLOUD` to `1`, while also defining the `ZPHRASE` and `ZSHORTCUT`.

These changes are not synced to iCloud immediately and may require a system restart.

### Todos

- Implement both `Terminal.app` and `iTerm2.app` themes (and `iTerm2.app` configures).
- Create application shortcut adjustments.
- Properly implement text replacements.
- Configure the Finder sidebar.
- Configure Transmission properly.
- Set the desktop background, even.
- Configure `pmset`.
- Remove prerequisites for both `yarn` and `node` existing on the system to run `dotfiles.sh`, by migrating to Rust.
- Try to follow the patterns set out by [dotfiles.github.io][2].
- Configure ~/.ssh/config and ~/.git/config.
- Configure vim config.
- Investigate hushlogin.
- Investigate neofetch configuration.

[1]: https://github.com/mathiasbynens/dotfiles
[2]: https://dotfiles.github.io
[3]: https://github.com/caarlos0/dotfiles/blob/master/macos/set-defaults.sh
[4]: https://eclecticlight.co/2019/08/22/working-safely-and-effectively-with-preferences-in-mojave/
