#!/usr/bin/env bash

declare -A osInfo;
osInfo['/etc/redhat-release']='yum'
osInfo['/etc/arch-release']='pacman'
osInfo['/etc/gentoo-release']='emerge'
osInfo['/etc/SuSE-release']='zypp'
osInfo['/etc/debian_version']='apt'

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

    PM_ORIGIN=$PM
    echo "PM: $PM"
    if ask "Install using sudo?"; then
        PM="sudo $PM"
    fi
}

perform_installation() {
    # Install command-line tools using $PM.
    # Make sure we’re using the latest $PM
    echo ""
    echo "Update packages info"
    $PM update

    # Upgrade any already-installed formulae
    # $PM upgrade

    echo ""
    echo "Install core utils"
    $PM install coreutils
    if [ "$PM_ORIGIN" = "yum" ] ; then
        $PM groupinstall "Development Tools"
        $PM install kernel-devel kernel-headers
    elif [ "$PM_ORIGIN" = "apt" ] ; then
        $PM install buildessntials
    fi

    # Rust
    echo ""
    if ask "Install Rust and ripgrep?"; then
        echo "Install Rust"
        curl https://sh.rustup.rs -sSf | sh
        source $HOME/.cargo/env
        cargo install ripgrep
    fi

    # ---------------------------------------------
    # Programming Languages and Frameworks
    # ---------------------------------------------

    # Python 3
    echo ""
    echo "Install python"
    $PM install python3

    # Show directory structure with excellent formatting
    echo ""
    echo "Install tree"
    $PM install tree

    # tmux :'D
    echo ""
    echo "Install tmux"
    $PM install tmux

    # gdb
    echo ""
    echo "Install and setup gdb"
    $PM install gdb

    $PM install subversion
    svn co svn://gcc.gnu.org/svn/gcc/trunk/libstdc++-v3/python $XDG_DATA_HOME/gdb_python


    # setup vim
    echo ""
    echo "Install and setup vim"
    $PM install vim
    mkdir -p "$HOME/.vim/bundle"
    git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall

    $PM install ctags

    # setup fonts
    echo ""
    echo "Install powerline fonts"
    $PM install fonts-powerline

}


choose_pm
perform_installation

