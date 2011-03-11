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
set number

" get nice alignment up to 9999
set numberwidth=5

" 2-wide tabs have grown on me
set shiftwidth=2
set softtabstop=2

" make it obvious when tabs are being used
set tabstop=8

" 78 characters wide
set textwidth=78

" spaces, that is all
set expandtab

" never wrap
set nowrap
set shiftround
set smartcase

" give us a decent status line
set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]

" who types \, anyway?
let mapleader=","

" Command-T
map <Leader>t :CommandT<CR>
map <Leader>f :CommandTFlush<CR>

" NERDTree! 
map <Leader>, :NERDTreeToggle<CR>

if &term == 'xterm-color'
  " get more colors
  set t_Co=16
  " hack for console Command-T mappings
  let g:CommandTCancelMap=['<ESC>','<C-c>']
  let g:CommandTSelectPrevMap=['<C-p>', '<C-k>', '<Esc>OA', '<Up>']
  let g:CommandTSelectNextMap=['<C-n>', '<C-j>', '<Esc>OB', '<Down>']
endif

if has("gui_running")
  set background=dark
  set guifont=Inconsolata:h17
  set guicursor=n:blinkon0

  " highlight current line
  set cursorline

  colorscheme desert

  " fix non text lines
  hi NonText NONE
  hi NonText ctermfg=1 guifg=LightBlue

  " use Command-1..9 to switch between open tabs
  map <D-1> :tabn 1<CR>
  map <D-2> :tabn 2<CR>
  map <D-3> :tabn 3<CR>
  map <D-4> :tabn 4<CR>
  map <D-5> :tabn 5<CR>
  map <D-6> :tabn 6<CR>
  map <D-7> :tabn 7<CR>
  map <D-8> :tabn 8<CR>
  map <D-9> :tabn 9<CR>
  map! <D-1> <C-O>:tabn 1<CR>
  map! <D-2> <C-O>:tabn 2<CR>
  map! <D-3> <C-O>:tabn 3<CR>
  map! <D-4> <C-O>:tabn 4<CR>
  map! <D-5> <C-O>:tabn 5<CR>
  map! <D-6> <C-O>:tabn 6<CR>
  map! <D-7> <C-O>:tabn 7<CR>
  map! <D-8> <C-O>:tabn 8<CR>
  map! <D-9> <C-O>:tabn 9<CR>

  set columns=80 lines=60
endif

" use subtle colors for line number
hi LineNr ctermfg=darkgray guifg=grey50

" recursively scan up for a tags file
:set tags=tags;/,TAGS;/
