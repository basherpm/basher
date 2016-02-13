# basher

A package manager for bash scripts and functions.

Basher allows you to quickly install bash packages directly from github. Instead of looking for specific install instructions for each package and messing with your path, basher will create a central location for all packages and manage their binaries for you.

[![Build Status](https://travis-ci.org/basherpm/basher.svg?branch=master)](https://travis-ci.org/basherpm/basher)

## Installation

1. Checkout basher on `~/.basher`

    ~~~ sh
    $ git clone https://github.com/basherpm/basher.git ~/.basher
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

## Updating

Run `basher update` to update basher.

## Usage

### Installing packages

~~~ sh
$ basher install sstephenson/bats
~~~

This will install bats from https://github.com/sstephenson/bats and add `bin/bats` to the PATH.

### Command summary

- `basher commands` - List commands
- `basher help <command>` - Displays help for a command
- `basher uninstall <package>` - Uninstall a package
- `basher update` - Update basher to latest version from master
- `basher list` - List installed packages
- `basher outdated` - List packages which are not in the latest version
- `basher upgrade <package>` - Upgrades a package to the latest version

## Packages

Packages are simply github repos (username/repo).

Any files inside a bin directory are added to the path. If there is no bin directory, any executable files in the package root are added to the path.

Any files inside a man directory are added to the manpath.

Optionally, a repo might contain a `package.sh` file which specifies binaries, dependencies and completions in the following format:

~~~ sh
BINS=folder/file1:folder/file2.sh
DEPS=user1/repo1:user2/repo2
BASH_COMPLETIONS=completions/package
ZSH_COMPLETIONS=completions/_package
~~~

BINS specified in this fashion have higher precedence then the inference rules
above.

## Working packages

- [basherpm/todo](https://github.com/basherpm/todo)
- [bltavares/kickstart](https://github.com/bltavares/kickstart)
- [bripkens/dock](https://github.com/bripkens/dock)
- [juanibiapina/gg](https://github.com/juanibiapina/gg)
- [juanibiapina/pg](https://github.com/juanibiapina/pg)
- [pote/gpm](https://github.com/pote/gpm)
- [pote/gvp](https://github.com/pote/gvp)
- [sstephenson/bats](https://github.com/sstephenson/bats)
- [tj/git-extras](https://github.com/tj/git-extras)
- [treyhunner/tmuxstart](https://github.com/treyhunner/tmuxstart)

And many others. If a repo doesn't work, create an issue or a pull request.

## Development

To run the tests, install bats:

~~~ sh
$ basher install sstephenson/bats
~~~

and then run:

~~~ sh
$ bats tests
~~~
