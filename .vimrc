set nocompatible

set tabstop=4
set expandtab
set softtabstop=4
set shiftwidth=4
set shiftround
set cursorline

set ignorecase
set exrc

" Visual " {{{
    set number
    set numberwidth=4
    set laststatus=2
    set hlsearch
    " set nowrap
    set listchars=eol:¬,tab:>·,trail:␣,extends:>,precedes:<
    set list
    set noswapfile
    set incsearch

    set foldmethod=syntax
    set foldnestmax=10
    set foldlevel=2
    set nofoldenable
    set complete-=i
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

    " Clipboard
    Plugin 'kana/vim-fakeclip'

    " Search
    Plugin 'jremmen/vim-ripgrep'

    call vundle#end()
" " }}}

filetype plugin indent on
color elflord
syntax on

" Detect Imagine " {{{
    function! BuildImagine()
        let g:App = fnamemodify(system('find --maxdepth 3 . -name app.asm'), ':h:t')
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
    " map <C-M> :Tags<CR>

    " Map function keys
    nmap <F3> :call SmartTag#SmartTag("goto")<CR>
    noremap <F4> :noh<CR>
    map <F5> :cprevious<CR>
    map <F6> :cnext<CR>
    set pastetoggle=<F7>
    map <F8> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
    map <F12> :make<CR>
    map! <F12> <ESC>:make<CR>i

    cnoreabbrev tn tabnew
    cnoreabbrev th tabp
    cnoreabbrev tl tabn
    cnoreabbrev tm tabm

" " }}}

" Airline Configuration " {{{
    "let g:airline#extensions#tabline#enabled = 1
    let g:airline_powerline_fonts = 1
    let g:airline_theme='base16_harmonic16'
" " }}}

" For completion " {{{
    set nocp
    filetype plugin on
    nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 3/2)<CR>
    nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
    "nmap <C-_><C-W> :call SmartTag#SmartTag("split")<CR>
    "nmap <C-_><C-T> :call SmartTag#SmartTag("tab")<CR>
    "nmap <C-_><C-D> :call SmartTag#SmartTag("debug")<CR>
" " }}}


" Go to last active tab

au tabLeave * let g:lasttab = tabpagenr()
nnoremap <silent> <C-,> :exe "tabn ".g:lasttab<cr>
vnoremap <silent> <C-,> :exe "tabn ".g:lasttab<cr>


"" Splits
set splitbelow
set splitright

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

