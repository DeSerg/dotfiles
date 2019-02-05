set nocompatible

set tabstop=4
set expandtab
set softtabstop=4
set shiftwidth=4
set shiftround

set ignorecase
set exrc

" Visual " {{{
    set number
    set numberwidth=4
    set laststatus=2
    set hlsearch
    set nowrap
    set listchars=eol:¬,tab:>·,trail:␣,extends:>,precedes:<
    set list
" " }}}

" Plugins " {{{
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()

    Plugin 'VundleVim/Vundle.vim'

    " UI
    Plugin 'scrooloose/nerdtree'
    Plugin 'junegunn/fzf'
    Plugin 'junegunn/fzf.vim'
    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'
    Plugin 'majutsushi/tagbar'

    " Git stuff
    Plugin 'tpope/vim-git'
    Plugin 'tpope/vim-fugitive'

    " Syntax
    Plugin 'tpope/vim-markdown'
    Plugin 'posva/vim-vue'

    " Themes
    Plugin 'sjl/badwolf'
    Plugin 'morhetz/gruvbox'

    " Corrections
    Plugin 'gagoar/stripwhitespaces'

    " Compete
    Plugin 'OmniCppComplete'
    Plugin 'marcweber/smarttag'

    call vundle#end()
" " }}}

filetype plugin indent on
color elflord
syntax on

" Detect Imagine " {{{
    function! BuildImagine()
        let g:App = fnamemodify(system('find . -name app.asm'), ':h:t')
        if g:App != '.'
            execute "set makeprg=./asm\\ -M\\ ".g:App
            " "."\\ NEED_ASANITIZER=1"
        endif
    endfunction!
    call BuildImagine()
" " }}}

" Keyboard " {{{
    map <F2> :NERDTreeToggle<CR>
    map <C-P> :Files<CR>
    map <C-K> :Tags<CR>
    map <F12> :make<CR>
    map! <F12> <ESC>:make<CR>i

    set pastetoggle=<F9>
" " }}}

" Airline Configuration " {{{
    "let g:airline#extensions#tabline#enabled = 1
    let g:airline_powerline_fonts = 0
    let g:airline_theme='base16_harmonic16'
" " }}}

" For completion " {{{
    set nocp
    filetype plugin on
    map <F10> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
    nmap <F3> :call SmartTag#SmartTag("goto")<CR>
    "nmap <C-_><C-W> :call SmartTag#SmartTag("split")<CR>
    "nmap <C-_><C-T> :call SmartTag#SmartTag("tab")<CR>
    "nmap <C-_><C-D> :call SmartTag#SmartTag("debug")<CR>
    map <F5> :cprevious<CR>
    map <F6> :cnext<CR>
" " }}}
