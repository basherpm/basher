# basher

A package manager for bash scripts and functions.

Basher allows you to quickly install bash packages directly from github. Instead of looking for specific install instructions for each package and messing with your path, basher will create a central location for all packages and manage their binaries for you.

[![Build Status](https://travis-ci.org/basherpm/basher.svg?branch=master)](https://travis-ci.org/basherpm/basher)

## Installation

1. Checkout basher on `~/.basher`

    ~~~ sh
    $ git clone git://github.com/basherpm/basher.git ~/.basher
    ~~~

2. Add `~/.basher/bin` to `$PATH` for easy access to the basher command-line utility.

    ~~~ sh
    $ echo 'export PATH="$HOME/.basher/bin:$PATH"' >> ~/.bash_profile
    ~~~

    **Ubuntu Desktop note**: Modify your `~/.bashrc` instead of `~/.bash_profile`.

    **Zsh note**: Modify your `~/.zshrc` file instead of `~/.bash_profile`.

    **For Fish**: Add the following to you `~/.config/fish/config.fish`

    ~~~ sh
    if test -d ~/.basher
      set basher ~/.basher/bin
    end
    set -gx PATH $basher $PATH
    ~~~

3. Add `basher init` to your shell to enable basher runtime functions

    ~~~ sh
    $ echo 'eval "$(basher init -)"' >> ~/.bash_profile
    ~~~

    _Same as in previous step, use `~/.bashrc` on Ubuntu, `~/.zshrc` for Zsh._

    _For **Fish**, use the following line on your `~/.config/fish/config.fish`._

    ~~~ sh
    status --is-interactive; and . (basher init -|psub)
    ~~~

## Usage

### Installing packages

~~~ sh
$ basher install sstephenson/bats
~~~

This will install bats from https://github.com/sstephenson/bats and add `bin/bats` it to the PATH.

### Using package runtimes

If a package exports a runtime, you can include it in the current shell by running, for instance:

~~~ sh
require juanibiapina/gg
~~~

### Command summary

- `basher commands` - List commands
- `basher help <command>` - Displays help for a command
- `basher uninstall <package>` - Uninstall a package
- `basher update` - Update basher to latest version from master
- `basher list` - List installed packages
- `basher outdated` - List packages which are not in the latest version
- `basher upgrade <package>` - Upgrades a package to the latest version

## Packages

Packages are github repos (username/repo) which contain a `package.sh` file with the following format:

~~~ sh
BIN=bin/exec1:bin/exec2
RUNTIME=lib/functions.sh
~~~

BIN is a ":" separated list of binaries that will be added to the path.

RUNTIME is a file that will be sourced when using the `require` function.

If a `package.sh` file is not found, basher will try to link any binaries inside the `bin` folder of the project.

## Development

To run the tests, install bats:

~~~ sh
$ basher install sstephenson/bats
~~~

and then run:

~~~ sh
$ bats tests
~~~
