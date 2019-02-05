# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
alias tags_upd=`ctags -R --c++-kinds=+p --fields=+iaS --extra=+q`

alias transfer='curl --upload-file'

PS1="\[\033[01;32m\]\u\[\033[00m\] \[\033[01;34m\]\w \$\[\033[00m\] "

# Do not stuck on Ctrl+S in vim
stty -ixon
