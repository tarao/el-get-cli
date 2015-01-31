elget --- A command line interface for [El-Get][]
=================================================

`elget` is a command line interface for [El-Get][].  You can
install/update packages by running commands as you do `M-x
el-get-install` or `M-x el-get-update` on Emacs.  It also supports
package version locks provided by [`el-get-lock`][el-get-lock].

## Installation

```sh
cd ~ && git clone https://github.com/tarao/el-get-cli .el-get-cli
export PATH="$HOME/.el-get-cli/bin:$PATH"
```

## Usage

To use the following commands, you need [El-Get][] to be installed and
initialized in your Emacs init file.

- `elget OPTIONS install [PACKAGES ...]`

  Install specified packages.  Without packages, it runs an ordinary
  install sequence according to instructions in your Emacs init file.

- `elget OPTIONS update [PACKAGES ...]`

  Update specified packages to the latest versions of their remote
  source.  Without packages, it updates all the installed packages.

To use the following commands, you need [`el-get-lock`][el-get-lock]
to be installed and initialized in your Emacs init file.

- `elget OPTIONS lock [PACKAGES ...]`

  Lock specified packages.  Without packages, it resets the lock
  status to lock the all installed packages.

- `elget OPTIONS unlock [PACKAGES ...]`

  Unlock specified packages.  Without packages, it resets the lock
  status to unlock the all installed packages.

- `elget OPTIONS checkout [PACKAGES ...]`

  Checkout the locked versions of specified packages.  Without
  packages, it checks out all the installed packages.

### Options

- `-f <file>`

  Specify an Emacs init file.

### Environment variables

- `EMACS`

  Specify the location of Emacs binary.

## Tips: isolating your Emacs init file from the default directory

By `-f` option, you can specify an Emacs init file to initialize
[El-Get][].  This helps you to try `elget` with a local Emacs init
file other than the default `~/.emacs.d/init.el` but the [El-Get][]
package installation directory is still `~/.emacs.d/el-get` by
default.

To get the [El-Get][] installation directory isolated from the default
one, put the following code in your (local) Emacs init file (before
the initialization of [El-Get][]).

```elisp
(when load-file-name
  (setq user-emacs-directory (file-name-directory load-file-name)))
```

This changes the user Emacs directory (`~/.emacs.d` by default) to the
directory where the (local) Emacs init file is located so that
[El-Get][] will chooose the package directory under this directory.
For example, if you (local) Emacs init file is
`~/el-get-test/init.el`, then the [El-Get][] package directory will be
`~/el-get-test/el-get`.

Actually, setting `user-emacs-directory` at the beginning of the user
Emacs file will maintain all the well-written Emacs Lisp packages that
use the user Emacs directory.  So you should always do this to make
you init file portable.

To run your Emacs with the local Emacs init file, run the following command.

```
emacs -q -l YOUR-LOCAL-INIT-FILE.el
```

[El-Get]: http://github.com/dimitri/el-get
[el-get-lock]: http://github.com/tarao/el-get-lock
