#!/usr/bin/env bash

declare -A osInfo;
osInfo[/etc/redhat-release]=yum
osInfo[/etc/arch-release]=pacman
osInfo[/etc/gentoo-release]=emerge
osInfo[/etc/SuSE-release]=zypp
osInfo[/etc/debian_version]=apt

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

    echo "PM: $PM"
    if ask "Install using sudo?"; then
        PM="sudo $PM"
    fi
}

perform_installation() {
    # Install command-line tools using $PM.
    # Make sure we’re using the latest $PM
    $PM update

    # Upgrade any already-installed formulae
    # $PM upgrade

    # Core Utils
    $PM install coreutils

    # Rust
    if ask "Install Rust?"; then
        if [ "$PM" = "yum" ] ; then
            sudo yum-config-manager --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo
        fi

        $PM install ripgrep
    fi

    # ---------------------------------------------
    # Programming Languages and Frameworks
    # ---------------------------------------------

    # Python 3
    $PM install python3

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
    mkdir -p "$HOME/.vim/bundle"
    git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
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

