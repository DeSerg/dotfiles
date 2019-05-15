#!/bin/sh

declare -A osInfo;
osInfo[/etc/redhat-release]=yum
osInfo[/etc/arch-release]=pacman
osInfo[/etc/gentoo-release]=emerge
osInfo[/etc/SuSE-release]=zypp
osInfo[/etc/debian_version]=apt-get

declare -A pmScripts;
pmScripts[yum]=yum.exclude.sh
pmScripts[apt]=apt.exclude.sh


init () {
    source "./.bashrc"

    mkdir -p "$XDG_DATA_HOME"
    # Initialize a few things
    echo 'Initing...'
}

link () {
    echo "This utility will symlink the files in this repo to the home directory"
    echo "Proceed? (y/n)"
    read resp
    # TODO - regex here?
    if [ "$resp" = 'y' -o "$resp" = 'Y' ] ; then
        for file in $( ls -A | grep -vE '\.exclude*|\.git$|\.gitignore|.*.md' ) ; do
            ln -sv "$PWD/$file" "$HOME"
        done
        # TODO: source files here?
        echo "Symlinking complete"
    else
        echo "Symlinking cancelled by user"
        return 1
    fi
}

pm_exists () {
    # If the given key maps to a non-empty string (-n), the
    # key obviously exists. Otherwise, we need to check if
    # the special expansion produces an empty string or an
    # arbitrary non-empty string.
    [[ -n ${pmScripts[$1]} || -z ${psScripts[$1]-foo} ]]
}

install_tools () {
    osType="$(uname -s)"
    if [ "$osType" = "Linux" ] ; then

        for f in ${!osInfo[@]}
        do
            if [[ -f $f ]];then
                PM="${osInfo[$f]}"
            fi
        done

        if ! pm_exists $PM; then
            echo "Unable to install utilities due to unsupported package manager"
            return
        fi

        pm_script="$pmScripts[$PM]}"

        echo "This utility will install useful utilities using $PM"
        echo "Proceed? (y/n)"
        read resp
        # TODO - regex here?
        if [ "$resp" = 'y' -o "$resp" = 'Y' ] ; then
            echo "Installing useful stuff using $PM. This may take a while..."
            sh "$pm_script"
        else
            echo "Installation cancelled by user"
        fi
    elif [ "$osType" = "Darwin" ] ; then
        echo "This utility will install useful utilities using Homebrew"
        echo "Proceed? (y/n)"
        read resp
        if [ "$resp" = 'y' -o "$resp" = 'Y' ] ; then
            echo "Installing useful stuff using brew. This may take a while..."
            sh brew.exclude.sh
        else
            echo "Brew installation cancelled by user"
        fi
    else
        echo "Skipping installations because neither Homebrew nor Linux were detected..."
    fi
}

init
link
install_tools
