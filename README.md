# basher

A package manager for shell scripts and functions.

Basher allows you to quickly install shell packages directly from github (or
other sites). Instead of looking for specific install instructions for each
package and messing with your path, basher will create a central location for
all packages and manage their binaries for you.

Even though it is called basher, it also works with zsh and fish.

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

### Installing packages from github.com

~~~ sh
$ basher install sstephenson/bats
~~~

This will install bats from https://github.com/sstephenson/bats and add `bin/bats` to the PATH.

### Installing packages from other sites

~~~ sh
$ basher install bitbucket.org/user/repo_name
~~~

This will install `repo_name` from https://bitbucket.org/user/repo_name

### Using ssh instead of https

If you want to do local development on installed packages and you have ssh
access to the site, use `--ssh` to override the protocol:

~~~ sh
$ basher install --ssh juanibiapina/gg
~~~

### Using a fully qualified  clone url

If the package is found on a site that supports multi-level namespaces or if you have it
hosted on a server at a non-standard port, you can use a fully qualified clone url
to install the package. You can use `ssh` urls and `https` urls.

~~~ sh
$ basher install https://gitlab.com/company/group/repo_name.git
$ basher install git@gitlab.com:company/group/repo_name.git
$ basher install ssh://git@gitlab.mycompany.com:10022/devision/team/repo_name.git
~~~

### Installing a local package

If you develop a package locally and want to try it through basher,
use the `link` command:

~~~ sh
$ basher link directory my_namespace/my_package
~~~

The `link` command will install the dependencies of the local package.
You can prevent that with the `--no-deps` option:

~~~ sh
$ basher link --no-deps directory my_namespace/my_package
~~~

### Sourcing files from a package into current shell

Basher provides an `include` function that allows sourcing files into the
current shell. After installing a package, you can run:

```
include username/repo lib/file.sh
```

This will source a file `lib/file.sh` under the package `username/repo`.

### Command summary

- `basher commands` - List commands
- `basher help <command>` - Display help for a command
- `basher uninstall <package>` - Uninstall a package
- `basher update` - Update basher to latest version from master
- `basher list` - List installed packages
- `basher outdated` - List packages which are not in the latest version
- `basher upgrade <package>` - Upgrade a package to the latest version

### Configuration options

To change the behavior of basher, you can set the following variables either
globally or before each command:

- `BASHER_FULL_CLONE=true` - Clones the full repo history instead of only the last commit (useful for package development)
- `BASHER_PREFIX` - set the installation and package checkout prefix (default is `$BASHER_ROOT/cellar`).  Setting this to `/usr/local`, for example, will install binaries to `/usr/local/bin`, manpages to `/usr/local/man`, completions to `/usr/local/completions`, and clone packages to `/usr/local/packages`.  This allows you to manage "global packages", distinct from individual user packages.

## Packages

Packages are simply repos (username/repo). You may also specify a site
(site/username/repo).

Any files inside a bin directory are added to the path. If there is no bin
directory, any executable files in the package root are added to the path.

Any manpages (files ended in `\.[0-9]`) inside a `man` directory are added
to the manpath.

Optionally, a repo might contain a `package.sh` file which specifies binaries,
dependencies and completions in the following format:

~~~ sh
BINS=folder/file1:folder/file2.sh
DEPS=user1/repo1:user2/repo2
BASH_COMPLETIONS=completions/package
ZSH_COMPLETIONS=completions/_package
~~~

BINS specified in this fashion have higher precedence then the inference rules
above.

## Development

To run the tests, install bats:

~~~ sh
$ basher install sstephenson/bats
~~~

update submodules:

~~~ sh
$ git submodule update --init
~~~

and then run:

~~~ sh
$ make
~~~
