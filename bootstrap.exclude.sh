#!/bin/bash

declare -A osInfo;
osInfo[/etc/redhat-release]=yum
osInfo[/etc/arch-release]=pacman
osInfo[/etc/gentoo-release]=emerge
osInfo[/etc/SuSE-release]=zypp
osInfo[/etc/debian_version]=apt-get

declare -A pmScripts;
pmScripts[yum]=yum.exclude.sh
pmScripts[apt]=apt.exclude.sh

ask () {
    echo "$1 (y/n)"
    read resp
    if [ "$resp" = 'y' -o "$resp" = 'Y' ] ; then
        return 0
    else
        return 1
    fi
}

init () {
    source "./.bashrc"

    mkdir -p "$XDG_DATA_HOME"
    # Initialize a few things
    echo 'Initing...'
}

symlink_files () {
    HOME_DIR=$1
    SUDO_PREF=$2

    if ask "Proceed with symlinking files in this repo to the home directory $HOME_DIR?"; then
        for file in $( ls -A | grep -vE '\.exclude*|\.git$|\.gitignore|.*.md|.ssh*' ) ; do
            $SUDO_PREF ln -sv "$PWD/$file" "$HOME_DIR"
        done

        # copy ssh config
        if ask "Copy ssh config?"; then
            $SUDO_PREF mkdir -p "$HOME_DIR/.ssh"

            ssh_config_path='ssh_config_common'
            if [[ -f $ssh_config_path ]];then
                $SUDO_PREF ln -sv "$PWD/$ssh_config_path" "$HOME_DIR/.ssh/config_common"
            fi
        fi

        # TODO: source files here?
        echo "Symlinking complete"
    fi
}

link () {
    symlink_files $HOME ""
    symlink_files "/root/" "sudo "
}

pm_exists () {
    # If the given key maps to a non-empty string (-n), the
    # key obviously exists. Otherwise, we need to check if
    # the special expansion produces an empty string or an
    # arbitrary non-empty string.
    [[ -n ${pmScripts[$1]} || -z ${psScripts[$1]-foo} ]]
}

install_tools () {
    echo "This utility will install useful utilities"
    echo "Proceed? (y/n)"
    read resp
    if [ "$resp" = 'y' -o "$resp" = 'Y' ] ; then
        echo "Installing useful stuff using $PM. This may take a while..."
        sh install_tools.exclude.sh
    else
        echo "Installation cancelled by user"
    fi
}

init
link
install_tools
