# .bashrc

: ${XDG_DATA_HOME:="$HOME/.local/share"}
export XDG_DATA_HOME

# User specific aliases and functions
alias tags_upd='ctags -R --c++-kinds=+p --fields=+iaS --extra=+q'

# Do not stuck on Ctrl+S in vim
stty -ixon

transfer(){ if [ $# -eq 0 ];then echo "No arguments specified.\nUsage:\n transfer <file|directory>\n ... | transfer <file_name>">&2;return 1;fi;if tty -s;then file="$1";file_name=$(basename "$file");if [ ! -e "$file" ];then echo "$file: No such file or directory">&2;return 1;fi;if [ -d "$file" ];then file_name="$file_name.zip" ,;(cd "$file"&&zip -r -q - .)|curl --progress-bar --upload-file "-" "https://t.bk.ru/$file_name"|tee /dev/null,;else cat "$file"|curl --progress-bar --upload-file "-" "https://t.bk.ru/$file_name"|tee /dev/null;fi;else file_name=$1;curl --progress-bar --upload-file "-" "https://t.bk.ru/$file_name"|tee /dev/null;fi;}

[ -f "${HOME}/.bashrc.im" ] && source "${HOME}/.bashrc.im"
[ -f "${HOME}/.bashrc.local" ] && source "${HOME}/.bashrc.local"

