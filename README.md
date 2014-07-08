# basher

A package manager for shell scripts and functions.

## Installation

1. Checkout basher on `~/.basher`

    ~~~ sh
    $ git clone git://github.com/juanibiapina/basher.git ~/.basher
    ~~~

2. Add `~/.basher/bin` to `$PATH` for easy access to the basher command-line utility.

    ~~~ sh
    $ echo 'export PATH="$HOME/.basher/bin:$PATH"' >> ~/.bash_profile
    ~~~

    **Ubuntu note**: Modify your `~/.profile` instead of `~/.bash_profile`.

    **Zsh note**: Modify your `~/.zshrc` file instead of `~/.bash_profile`.

3. Add `basher init` to your shell to enable basher runtime functions

    ~~~ sh
    $ echo 'eval "$(basher init -)"' >> ~/.bash_profile
    ~~~

    _Same as in previous step, use `~/.profile` on Ubuntu, `~/.zshrc` for Zsh._

## Usage

### Installing packages

~~~ sh
$ basher install sstephenson bats
~~~

This will install bats from https://github.com/sstephenson/bats and add `bin/bats` it to the PATH.

### Command summary

- `basher commands` - List commands
- `basher help <command>` - Displays help for a command
- `basher uninstall <package>` - Uninstall a package
- `basher update` - Update basher to latest version from master
- `basher list` - List installed packages
- `basher outdated` - List packages which are not in the latest version
- `basher upgrade <package>` - Upgrades a package to the latest version

## Packages

Packages are github repos which contain a `package.sh` file with the following format:

~~~ sh
BIN=bin/exec1:bin/exec2
~~~

If a `package.sh` file is not found, basher will try to link any binaries inside the `bin` folder of the project.

## Development

To run the tests, install bats:

~~~ sh
$ basher install sstephenson bats
~~~

and then run:

~~~ sh
$ bats tests
~~~
