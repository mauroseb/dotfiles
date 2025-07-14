# Mauro's dotfiles

Yet another dotfiles repo

## Tools

What is being configured by the dotfiles.

 - vim
 - tmux
 - hexchat
 - bash
 - zsh
 - git
 - gpg
 - gdb

Plus installing a bunch of useful tools.

## Setup

Clone repo and setup all the dot files.
~~~
$ git clone https://github.com/mauroseb/dotfiles.git
$ cd dotfiles
$ make all
$ git submodule update --recursive --remote
~~~

## Rollback Changes

Removes links to unset config files.
~~~
$ make unlink
~~~
