" pathogen ftw
call pathogen#runtime_append_all_bundles()

" on OS X, zsh prepends /usr/bin and others to PATH if called with -c, meaning
" system ruby/python is used. interactive mode doesn't fix it, behaves oddly.
" so just use good old sh.
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
set listchars=tab:>-,trail:-

" prefix lines with line numbers,
" get nice alignment up to 9999
" set number
" set numberwidth=5

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

" 78 characters, the one true line width
set textwidth=78

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
nnoremap <leader>f :CommandTFlush<cr>\|:CommandT<cr>
" Open files, limited to the directory of the current file, with <leader>gf
map <leader>gf :CommandTFlush<cr>\|:CommandT %%<cr>
nnoremap <leader>, :NERDTreeToggle<cr>
nnoremap <leader>m :make<cr>
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gl :Glog<cr>
nnoremap <leader>gpm :Git push origin master<cr>

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

function SetupRubyUnitTest()
  compiler rubyunit
  set makeprg=ruby\ -Ilib\ -I../lib\ -r\ test/unit
  nnoremap <leader>t :call MakeTestRunner(1)<cr>
  nnoremap <leader>T :call MakeTestRunner(0)<cr>
endfunction

" Ensure makeprg gets set for testing
autocmd! BufNewFile,BufReadPre,FileReadPre test_*.rb call SetupRubyUnitTest()
autocmd! BufNewFile,BufReadPre,FileReadPre *_test.rb call SetupRubyUnitTest()

" highlighting customizations
let ruby_operators = 1
hi LineNr ctermfg=darkgray guifg=grey50

" hacks and workarounds
" Command-T menus don't seem to work right without this
let g:CommandTCancelMap=['<ESC>','<C-c>']
let g:CommandTSelectPrevMap=['<C-p>', '<C-k>', '<Esc>OA', '<Up>']
let g:CommandTSelectNextMap=['<C-n>', '<C-j>', '<Esc>OB', '<Down>']

" solarized ftw
" set background=dark
colorscheme solarized

" some GUI settings
if has("gui_running")
  set guifont=Inconsolata:h19
  set guicursor=n:blinkon0
  " highlight current line
  set cursorline
  " no toolbar
  set guioptions-=T

  " get rid of ugly two-part background colors
  hi NonText NONE
  hi NonText ctermfg=1 guifg=LightBlue

  " use Command-1..9 to switch between open tabs
  map <D-1> :tabn 1<cr>
  map <D-2> :tabn 2<cr>
  map <D-3> :tabn 3<cr>
  map <D-4> :tabn 4<cr>
  map <D-5> :tabn 5<cr>
  map <D-6> :tabn 6<cr>
  map <D-7> :tabn 7<cr>
  map <D-8> :tabn 8<cr>
  map <D-9> :tabn 9<cr>
  map! <D-1> <C-O>:tabn 1<cr>
  map! <D-2> <C-O>:tabn 2<cr>
  map! <D-3> <C-O>:tabn 3<cr>
  map! <D-4> <C-O>:tabn 4<cr>
  map! <D-5> <C-O>:tabn 5<cr>
  map! <D-6> <C-O>:tabn 6<cr>
  map! <D-7> <C-O>:tabn 7<cr>
  map! <D-8> <C-O>:tabn 8<cr>
  map! <D-9> <C-O>:tabn 9<cr>

  set columns=80 lines=40
endif