# basher

A package manager for shell scripts and functions.

# Installation

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

# Usage

## Installing modules

~~~ sh
$ basher install sstephenson bats
~~~

This will install bats from https://github.com/sstephenson/bats and add it to the PATH.

# Modules

Modules are simply github repos which may contain a bin directory with an executable file.

# Runtime functions

## require

~~~ sh
require module_name
~~~

# Development

To run the tests, install bats:

~~~ sh
$ basher install sstephenson bats
~~~

and then run:

~~~ sh
$ bats tests
~~~
