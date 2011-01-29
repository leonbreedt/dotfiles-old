" bitserf's vimrc

" syntax highlighting, thanks
syntax on
filetype plugin indent on

" classic vi, ugh
set nocompatible

" backspacing through space indentation is neat
set backspace=indent,eol,start

" stop cluttering up my disk
set nobackup
set directory=~/.vim/tmp

" try all formats, we move around a lot
set fileformats=unix,dos,mac

" useful keywords!
set iskeyword+=_,$,@,%,#

" stop beeping!
set noerrorbells

" completion
set wildmenu
set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.gif,*.png
set wildmode=list:longest

" incremental search is nice
set incsearch

" always show status line
set laststatus=2
set listchars=tab:>-,trail:-

" prefix lines with line numbers
" set number

" get nice alignment up to 9999
set numberwidth=5

" 2-wide tabs have grown on me
set shiftwidth=2
set softtabstop=2

" make it obvious when tabs are being used
set tabstop=8

" spaces, that is all
set expandtab

" never wrap
set nowrap
set shiftround
set smartcase

" give us a decent status line
set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]

" use subtle colors for line number
hi LineNr ctermfg=darkgray

" recursively scan up for a tags file
set tags=tags;/,TAGS;/

" NERDTree! 
map ,, :NERDTreeToggle<CR>

" Command-T
map ,t :CommandT<CR>
map ,f :CommandTFlush<CR>
