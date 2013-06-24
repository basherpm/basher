# What is it?

A tool to make it easier to manage bash modules.

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

Clone the module inside ~/.basher/modules

## Runtime functions

### require

`require module_name`
