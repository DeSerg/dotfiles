#!/usr/bin/env bash

# Install command-line tools using brew.
# Make sure we’re using the latest brew
brew update

# Upgrade any already-installed formulae
brew upgrade

# Core Utils
brew install coreutils


# ---------------------------------------------
# Programming Languages and Frameworks
# ---------------------------------------------
# Python 3
brew install python

# ---------------------------------------------
# Tools I use often
# ---------------------------------------------

# Docker for containerization
brew install docker


# ---------------------------------------------
# Database Systems I use Often
# ---------------------------------------------

# ---------------------------------------------
# Useful tools
# ---------------------------------------------

# Show directory structure with excellent formatting
brew install tree

# tmux :'D
brew install tmux

# gdb
brew install gdb

# setup vim
brew install vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

# ---------------------------------------------
# Misc
# ---------------------------------------------

# Remove outdated versions from the cellar
brew cleanup

