" ===={ My Functions }============================================= {{{1
" ----[ Make the 81st column stand out ]--------------------------- {{{2
" OR ELSE just the 81st column of wide lines...
function! myfuncs#81colcolumn()
  highlight ColorColumn ctermbg=9 ctermfg=7
  call matchadd('ColorColumn', '\%81v', 100)
endfunction
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
" ----[ Smart Tab Complete ]--------------------------------------------{{{2
function! myfuncs#Smart_TabComplete()
  let line = getline('.')                         " current line

  let substr = strpart(line, -1, col('.')+1)      " from the start of the current
                                                  " line to one character right
                                                  " of the cursor
  let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
  if (strlen(substr)==0)                          " nothing to match on empty string
    return "\<tab>"
  endif
  let has_period = match(substr, '\.') != -1      " position of period, if any
  let has_slash = match(substr, '\/') != -1       " position of slash, if any
  if (!has_period && !has_slash)
    return "\<C-X>\<C-P>"                         " existing text matching
  elseif ( has_slash )
    return "\<C-X>\<C-F>"                         " file matching
  else if
    return "\<C-X>\<C-O>"                         " plugin matching
  else
      return "\<tab>"
  endif
endfunction
" ---[ Neomake battery check ]-------------------------------------{{{2
function! myfuncs#MyOnBattery()
  return readfile('/sys/class/power_supply/AC/online') == ['0']
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
" ----[ Open unsupported files ]-----------------------------------{{{2
" What command to use
function! myfuncs#OpenAll() abort
    " Linux/BSD
    if executable("xdg-open")
        return "xdg-open"
    endif
    " MacOS
    if executable("open")
        return "open"
    endif
    " Windows
    return "explorer"
endfunction
