# .bashrc

: ${XDG_DATA_HOME:="$HOME/.local/share"}
export XDG_DATA_HOME

# User specific aliases and functions
alias tags_upd='ctags -R --c++-kinds=+p --fields=+iaS --extra=+q'

# Do not stuck on Ctrl+S in vim
stty -ixon

[ -f "${HOME}/.bashrc.im" ] && source "${HOME}/.bashrc.im"
[ -f "${HOME}/.bashrc.local" ] && source "${HOME}/.bashrc.local"

