#!/usr/bin/env bash

# Install command-line tools using apt.
# Make sure we’re using the latest apt
apt update

# Upgrade any already-installed formulae
apt upgrade

# Core Utils
apt install coreutils

# Rust
curl https://sh.rustup.rs -sSf | sh
source $HOME/.cargo/env

# ripgrep
git clone https://github.com/BurntSushi/ripgrep
pushd ripgrep
cargo build --release
./target/release/rg --version
mkdir -p $HOME/bin/
cp ./target/release/rg $HOME/bin/
popd
sudo rm -r ripgrep

# ---------------------------------------------
# Programming Languages and Frameworks
# ---------------------------------------------

# Python 3
apt install python

# Show directory structure with excellent formatting
apt install tree

# tmux :'D
apt install tmux

# gdb
apt install gdb

apt install subversion
svn co svn://gcc.gnu.org/svn/gcc/trunk/libstdc++-v3/python $XDG_DATA_HOME/gdb_python


# setup vim
apt install vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

# setup fonts
apt install fonts-powerline

# ---------------------------------------------
# Misc
# ---------------------------------------------

# Remove outdated versions from the cellar
apt cleanup

