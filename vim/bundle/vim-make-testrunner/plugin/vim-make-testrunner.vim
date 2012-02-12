" Derived from vim-makegreen by Rein Henrichs (https://github.com/reinh/vim-makegreen/)

if &cp || exists("g:make_testrunner_loaded") && g:make_testrunner_loaded
  finish
endif
let g:make_testrunner_loaded = 1

let s:save_cpo = &cpo
set cpo&vim

hi GreenBar ctermfg=7 ctermbg=2 guifg=black guibg=green
hi RedBar   ctermfg=0 ctermbg=1 guifg=white guibg=red

function MakeTestRunner(...) "{{{1
  let is_quiet = a:0 ? a:1 : 0
  silent! w

  if is_quiet 
    let $VERBOSE = 0
    let s:old_sp = &shellpipe
    if has('unix')
      set shellpipe=&> "quieter make output
    endif
    silent! exec "make! %"
    let &shellpipe = s:old_sp
    if len(getqflist()) > 0
      setlocal switchbuf=split
      silent cc
    end
    redraw!
    let error = s:GetFirstError()
    if error != ''
      call s:Bar("red", "[FAIL] " . error)
    else
      call s:Bar("green", "[OK] All tests passed")
    endif
  else
    let $VERBOSE = 1
    exec "make! %"
  endif
endfunction
"}}}1
" Utility Functions" {{{1
function s:GetFirstError()
  if getqflist() == []
    return ''
  endif
  for error in getqflist()
    if error['valid']
      break
    endif
  endfor
  if ! error['valid']
    return ''
  endif
  let error_message = substitute(error['text'], '^ *', '', 'g')
  let error_message = substitute(error_message, "\n", ' ', 'g')
  let error_message = substitute(error_message, "  *", ' ', 'g')
  return error_message
endfunction

function s:Bar(type, msg)
  if a:type == "red"
    echohl RedBar
  else
    echohl GreenBar
  endif
  echon a:msg repeat(" ", &columns - strlen(a:msg) - 1)
  echohl None
endfunction

" }}}1

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set sw=2 sts=2:
