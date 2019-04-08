#!/usr/bin/env bash

# Install command-line tools using apt.
# Make sure we’re using the latest apt
apt update

# Upgrade any already-installed formulae
apt upgrade

# Core Utils
apt install coreutils


# ---------------------------------------------
# Programming Languages and Frameworks
# ---------------------------------------------

# NodeJS
apt install node

# Python 3
apt install python

# Golang
apt install go


# ---------------------------------------------
# Tools I use often
# ---------------------------------------------

# Heroku
apt install heroku

# Yarn - an alternative to npm
apt install yarn

# Docker for containerization
apt install docker


# ---------------------------------------------
# Database Systems I use Often
# ---------------------------------------------

# MongoDB :D
apt install mongo

# RedisDB
apt install redis


# ---------------------------------------------
# Useful tools
# ---------------------------------------------

# Make requests with awesome response formatting
apt install httpie

# Show directory structure with excellent formatting
apt install tree

# tmux :'D
apt install tmux

# gdb
apt install gdb

# setup vim
apt install vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

# ---------------------------------------------
# Misc
# ---------------------------------------------

# Remove outdated versions from the cellar
apt cleanup

