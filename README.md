# dotfiles

This repository contains my configuration files for **vim**, **tmux** and **zsh** and many other programs.

# usage

To make setting up on a new machine easy, the setup works like so:

- Clone the repo and place it in your home directory (~/dotfiles)
- Now, instead of storing your config files in their "intended locations" create a symbolic link from the location to the same file in this repo, for example from `~/.vimrc -> ~/dotfiles/nvim/minimal.vim`. This way any system with my dotfiles installed only uses the config files for the programs I care about on that particular system, and can get the most recent state by just pulling.


