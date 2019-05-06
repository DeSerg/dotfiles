#!/usr/bin/env bash

# Install command-line tools using apt.
# Make sure we’re using the latest yum
yum update

# ---------------------------------------------
# Programming Languages and Frameworks
# ---------------------------------------------

# Python 3
yum install python

# Show directory structure with excellent formatting
yum install tree

# tmux :'D
yum install tmux

# gdb
yum install gdb

yum install subversion
svn co svn://gcc.gnu.org/svn/gcc/trunk/libstdc++-v3/python $XDG_DATA_HOME/gdb_python


# setup vim
yum install vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall


# Remove outdated versions from the cellar
yum cleanup

