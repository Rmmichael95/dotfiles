" ===={ My Functions }============================================= {{{1
" ----[ CycleLang ]------------------------------ {{{2
function! myfuncs#CycleLang()
  let langs = ['', 'en_us', 'fr']

  let i = index(langs, &spl)
  let j = (i+1)%len(langs)
  let &spl = langs[j]

  if empty(&spl)
      set nospell
  else
      set spell
      hi clear SpellBad
      hi SpellBad cterm=underline ctermfg=9
  endif
endfun
" ----[ Open unsupported files ]-----------------------------------{{{2
" What command to use
function! myfuncs#OpenAll() abort
  if executable("xdg-open")
    return "xdg-open"
  endif
endfunction
" ----[ Include Guard ]--------------------------------------------{{{2
" function to generate c++ header guard, map in other section
function! myfuncs#IncludeGuard()
  let basename = substitute(bufname(""), '.*/', '', '')
  let guard = '_' . substitute(toupper(basename), '\.', '_', "H")
  call append(0, "#ifndef " . guard)
  call append(1, "#define " . guard)
  call append(line("$"), "#endif // for #ifndef " . guard)
endfunction
" ----[ Strip Whitespace ]--------------------------------------------{{{2
function! s:StripWhitespace(line1, line2)
    " Save the current search and cursor position
    let _s=@/
    let l = line('.')
    let c = col('.')

    silent execute ':' . a:line1 . ',' . a:line2 . 's/' . s:strip_whitespace_pattern . '//e'

    " Strip empty lines at EOF
    if g:strip_whitelines_at_eof == 1 && a:line2 >= line('$')
        silent execute '%s/\(\n\)\+\%$//e'
    endif

    " Restore the saved search and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
endfunction
