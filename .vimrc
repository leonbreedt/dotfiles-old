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

" spaces, that is all
set expandtab

" never wrap
set nowrap
set shiftround
set smartcase

" give us a decent status line
set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]

" Command-T
map ,t :CommandT<CR>
map ,f :CommandTFlush<CR>

if &term == 'xterm-color'
  " get more colors
  set t_Co=16
  " hack for console Command-T mappings
  let g:CommandTCancelMap=['<ESC>','<C-c>']
  let g:CommandTSelectPrevMap=['<C-p>', '<C-k>', '<Esc>OA', '<Up>']
  let g:CommandTSelectNextMap=['<C-n>', '<C-j>', '<Esc>OB', '<Down>']
end

" use subtle colors for line number
hi LineNr ctermfg=darkgray guifg=grey50

" recursively scan up for a tags file
set tags=tags;/,TAGS;/

" NERDTree! 
map ,, :NERDTreeToggle<CR>


" Steve Hall wrote this function vim@vim.org
    " See :help attr-list for possible attrs to pass
" disable bold fonts
function! Highlight_remove_attr(attr)
    " save selection registers
    new
    silent! put

    " get current highlight configuration
    redir @x
    silent! highlight
    redir END
    " open temp buffer
    new
    " paste in
    silent! put x

    " convert to vim syntax (from Mkcolorscheme.vim,
    "   http://vim.sourceforge.net/scripts/script.php?script_id=85)
    " delete empty,"links" and "cleared" lines
    silent! g/^$\| links \| cleared/d
    " join any lines wrapped by the highlight command output
    silent! %s/\n \+/ /
    " remove the xxx's
    silent! %s/ xxx / /
    " add highlight commands
    silent! %s/^/highlight /
    " protect spaces in some font names
    silent! %s/font=\(.*\)/font='\1'/

    " substitute bold with "NONE"
    execute 'silent! %s/' . a:attr . '\([\w,]*\)/NONE\1/geI'
    " yank entire buffer
    normal ggVG
    " copy
    silent! normal "xy
    " run
    execute @x

    " remove temp buffer
    bwipeout!

    " restore selection registers
    silent! normal ggVGy
    bwipeout!
endfunction
autocmd BufNewFile,BufRead * call Highlight_remove_attr("bold")
