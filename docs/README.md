<h2 align="center">
  <a href="https://github.com/z-shell/zi">
    <img src="https://github.com/z-shell/zi/raw/main/docs/images/logo.svg" alt="Logo" width="80" height="80" />
  </a>
❮ ZI ❯ - Console
</h2>

- [Introduction](#introduction)
- [Usage](#usage)
- [Screencast](#screencast)
- [Installation](#installation)
  - [Solving The Lack Of `zsh/curses` Module With ZI](#solving-the-lack-of-zshcurses-module-with-zi)

### Introduction

A consolette for [ZI](https://github.com/z-shell/zi) – based on the `zsh/zcurses` Zshell module allows the user to:

> Prerequisities: [ZUI](https://github.com/z-shell/zui) library

- view the currently loaded plugins in a colorful list, in one of 3 different display modes,
- unload and load plugins,
- delete the plugins and snippets from the disk.

### Usage

Start the consolette by Ctrl-O Ctrl-J keyboard shortcut, or by running
`ziconsole` function in the shell. Then, in the consolette:

| Key(s)             | Description                                                      |
| ------------------ | ---------------------------------------------------------------- |
| `Ctrl-U`,`Ctrl-D`  | Half page up; half page down                                     |
| `Ctrl-P`,`Ctrl-N`  | Previous line, centered; next line, centered                     |
| `Ctrl-L`           | Redraw of whole display                                          |
| `[`, `]`           | Jump to next and previous section (e.g.: next plugin or snippet) |
| `g`, `G`           | Jump to beginning and end of whole interface                     |
| `<`,`>` or `{`,`}` | Horizontal scroll (i.e.: left or right)                          |
| `/`                | Show incremental search                                          |
| `F1`               | Jump to result (in incremental search) and back                  |
| `Esc`              | Exit incremental search, clearing query                          |
| `Ctrl-W`           | Delete whole word (in incremental search)                        |
| `Ctrl-K`           | Delete whole line (in incremental search)                        |

### Screencast

[![asciicast](https://asciinema.org/a/272994.svg)](https://asciinema.org/a/272994)

### Installation

Load like any other normal plugin, e.g.:, with use of [Turbo
mode](https://z-shell.pages.dev/docs/getting_started/overview#turbo-mode-zsh--53) and the [for-syntax](https://z-shell.pages.dev/docs/guides/syntax#the-for-syntax):

```zsh
zi wait lucid for z-shell/zi-console
```

The plugin needs `zsh/curses` Zsh module. You can check if it's available to
your Zsh by executing:

```zsh
zmodload zsh/curses
```

If the call will return an error, then the `zsh/curses` module isn't available.

#### Solving The Lack Of `zsh/curses` Module With ZI

You can build the `zsh/curses`-equipped Zshell with ZI by the following
command:

```zsh
zi ice id-as"zsh" atclone"./.preconfig
        CFLAGS='-I/usr/include -I/usr/local/include -g -O2 -Wall' \
        LDFLAGS='-L/usr/lib -L/usr/local/lib' ./configure --prefix='$ZPFX'" \
    atpull"%atclone" run-atpull make"install" pick"/dev/null"
zi load zsh-users/zsh
```

The command will build a custom `zsh` and install it under `$ZPFX`
(`~/.zi/polaris` by default). The path `$ZPFX/bin` is already added to
`$PATH` by ZI at first position, so starting `zsh` will run the new Zshell.

When on Gentoo, and possibly other systems, the `zsh` can still not have the
ncurses library linked. To address this, utilize the
[z-a-patch-dl](https://github.com/z-shell/z-a-patch-dl) annex and
automatically patch the source first:

```zsh
zi light z-shell/z-a-patch-dl
zi ice id-as"zsh" atclone"./.preconfig
        CFLAGS='-I/usr/include -I/usr/local/include -g -O2 -Wall' \
        LDFLAGS='-L/usr/lib -L/usr/local/lib' ./configure --prefix='$ZPFX'" \
    dl"https://gist.githubusercontent.com/z-shell/2373494c71cb6d1529344a2ed1a64b03/raw -> curses.patch" \
    patch'curses.patch' atpull"%atclone" reset \
    run-atpull make"install" pick"/dev/null"
zi load zsh-users/zsh
```

Then, to update, rebuild and reinstall the `zsh`, you can do `zi update zsh`. The binary can be safely copied over `/bin/zsh` as it has paths to all
needed directories built-in.
