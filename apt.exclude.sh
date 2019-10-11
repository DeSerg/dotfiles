#!/usr/bin/env bash

declare -A osInfo;
osInfo[/etc/redhat-release]=yum
osInfo[/etc/arch-release]=pacman
osInfo[/etc/gentoo-release]=emerge
osInfo[/etc/SuSE-release]=zypp
osInfo[/etc/debian_version]='sudo apt'

ask () {
    echo "$1 (y/n)"
    read resp
    if [ "$resp" = 'y' -o "$resp" = 'Y' ] ; then
        return 0
    else
        return 1
    fi
}

choose_pm() {
    osType="$(uname -s)"
    if [ "$osType" = "Linux" ] ; then

        for f in ${!osInfo[@]}
        do
            if [[ -f $f ]];then
                PM="${osInfo[$f]}"
            fi
        done

        if [ -z "$PM" ]
        then
            echo "Unable to install utilities due to unsupported package manager"
            exit 1
        fi

    elif [ "$osType" = "Darwin" ] ; then
        PM=brew
    fi
}


perform_installation() {
    # Install command-line tools using $PM.
    # Make sure we’re using the latest $PM
    $PM update

    # Upgrade any already-installed formulae
    $PM upgrade

    # Core Utils
    $PM install coreutils

    # Rust
    if ask "Install Rust?"; then

        curl https://sh.rustup.rs -sSf >> rust.sh
        chmod +x rust.sh
        ./rust.sh -y
        rm rust.sh
        source $HOME/.cargo/env

        # ripgrep
        git clone https://github.com/BurntSushi/ripgrep
        pushd ripgrep
        cargo build --release
        ./target/release/rg --version
<<<<<<< HEAD
<<<<<<< HEAD
        cp ./target/release/rg $XDG_BIN_HOME/
=======
        cp ./target/release/rg $XDG_BIN_HOME/bin/
>>>>>>> d6d936b... single flexible setup script
=======
        cp ./target/release/rg $XDG_BIN_HOME/
>>>>>>> 480ba01... pkgs install update
        popd
        sudo rm -r ripgrep

    fi

    # ---------------------------------------------
    # Programming Languages and Frameworks
    # ---------------------------------------------

    # Python 3
    $PM install python

    # Show directory structure with excellent formatting
    $PM install tree

    # tmux :'D
    $PM install tmux

    # gdb
    $PM install gdb

    $PM install subversion
    svn co svn://gcc.gnu.org/svn/gcc/trunk/libstdc++-v3/python $XDG_DATA_HOME/gdb_python


    # setup vim
    $PM install vim
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall

    $PM install ctags

    # setup fonts
    $PM install fonts-powerline

    # ---------------------------------------------
    # Misc
    # ---------------------------------------------

    # Remove outdated versions from the cellar
    $PM cleanup

}


choose_pm
perform_installation

