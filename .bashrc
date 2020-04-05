# .bashrc

: ${XDG_DATA_HOME:="$HOME/.local/share"}
export XDG_DATA_HOME
mkdir -p $XDG_DATA_HOME

: ${XDG_BIN_HOME:="$HOME/.local/bin"}
export XDG_BIN_HOME
mkdir -p $XDG_BIN_HOME
[[ ":$PATH:" != *":$XDG_BIN_HOME:"* ]] && export PATH="${PATH}:$XDG_BIN_HOME"

# User specific aliases and functions
alias sudo='sudo '
alias tags_upd='ctags -R --c++-kinds=+p --fields=+iaS --extra=+q'

alias tmux-update-ssh-sock='export $(tmux showenv SSH_AUTH_SOCK)'
alias ssh-fix='ssh-add ~/.ssh/id_rsa'

# Do not stuck on Ctrl+S in vim
stty -ixon

transfer(){ if [ $# -eq 0 ];then echo "No arguments specified.\nUsage:\n transfer <file|directory>\n ... | transfer <file_name>">&2;return 1;fi;if tty -s;then file="$1";file_name=$(basename "$file");if [ ! -e "$file" ];then echo "$file: No such file or directory">&2;return 1;fi;if [ -d "$file" ];then file_name="$file_name.zip" ,;(cd "$file"&&zip -r -q - .)|curl --progress-bar --upload-file "-" "https://t.bk.ru/$file_name"|tee /dev/null,;else cat "$file"|curl --progress-bar --upload-file "-" "https://t.bk.ru/$file_name"|tee /dev/null;fi;else file_name=$1;curl --progress-bar --upload-file "-" "https://t.bk.ru/$file_name"|tee /dev/null;fi;}

[ -f "${HOME}/.bashrc.im" ] && source "${HOME}/.bashrc.im"
[ -f "${HOME}/.bashrc.local" ] && source "${HOME}/.bashrc.local"
[ -f "${HOME}/.unset_tmout" ] && source "${HOME}/.unset_tmout"

ggrep() {
    pattern="$1"
    shift
    git grep -i $pattern $@ $(git for-each-ref --format='%(refname)' refs/remotes | rg -v ".*\..*" | rg -v mimeparser) | rg -v core
}

export PATH="${HOME}/bin:${PATH}"
