# .bashrc

# User specific aliases and functions
alias tags_upd='ctags -R --c++-kinds=+p --fields=+iaS --extra=+q'

# Do not stuck on Ctrl+S in vim
stty -ixon

[ -f ".bashrc.im" ] && source ".bashrc.im"
[ -f ".bashrc.local" ] && source ".bashrc.local"

