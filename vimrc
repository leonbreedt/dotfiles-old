" just use good old sh to avoid weird.
set shell=/bin/sh

" syntax highlighting, thanks
syntax enable
filetype plugin indent on

" classic vi, ugh
set nocompatible

" backspacing through space indentation is neat
set backspace=indent,eol,start

" stop beeping
set vb t_vb=
set noerrorbells

" stop cluttering up my disk
set nobackup
set directory=~/.vim/tmp

" try all formats, we move around a lot
set fileformats=unix,dos,mac

" useful keywords!
set iskeyword+=_,$,@,%,#

" completion
set wildmenu
set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.gif,*.png
set wildmode=list:longest

" incremental search is nice
set incsearch

" always show status line
set laststatus=2
set noshowmode
set listchars=tab:>-,trail:-

" 2-wide tabs have grown on me
set shiftwidth=2
set softtabstop=2
set shiftround

" auto indent, yes please
set autoindent

" make it obvious when real tabs are being used
set tabstop=8

" tabs, just don't do it
set expandtab

" 80 characters, the one true line width
set textwidth=80

" never wrap
set nowrap
set smartcase

" give us a decent status line
set statusline=%F%m%y\ l:%l/%L\ c:%c

" recursively scan up for a tags file
set tags=tags;/,TAGS;/

" New horizontal windows on bottom
set splitbelow

" New vertical windows on right
set splitright

" who types \, anyway?
let mapleader=","

" global mappings for all buffers
" stolen from Gary Bernhardt
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%
nnoremap <leader><leader> <c-^>

" In splits, make current window big without destroying size of others.
set winwidth=84
set winheight=5
set winminheight=5
set winheight=999

" When re-opening file jump to last known position if its not invalid
" and not in an event handler -- from grb
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" |
  \ endif

" highlighting customizations
let ruby_operators = 1
hi LineNr ctermfg=darkgray guifg=grey50

" default error message not that readable
hi ErrorMsg term=reverse cterm=reverse ctermfg=1 ctermbg=0 guifg=White guibg=Red
