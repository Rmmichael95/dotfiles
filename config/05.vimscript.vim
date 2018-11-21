" ========{ Vim Script Functions }======================================== " {{{1
" ----[ Make the 81st column stand out ]--------------------------- {{{2
"  " OR ELSE just the 81st column of wide lines...
highlight ColorColumn ctermbg=9 ctermfg=7
call matchadd('ColorColumn', '\%81v', 100)
" ----[ Highlight matches when jumping to next ]------------------- {{{2
" This rewires n to do the highlighing...
"nnoremap <silent> n   n:call HLNext(0.4)<cr>
" OR ELSE just highlight the match in gold...
" fun! HLNext (blinktime)
"     let [bufnum, lnum, col, off] = getpos('.')
"     let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
"     let target_pat = '\c\%#\%('.@/.'\)'
"     let ring = matchadd('WhiteOnRed', target_pat, 101)
"     redraw
"     exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
"     call matchdelete(ring)
"     redraw
" endfun
" ----[ Always turn on syntax highlighting for diffs ]------------------ {{{2
" EITHER select by the file-suffix directly...
augroup PatchDiffHighlight
    autocmd!
    autocmd BufEnter  *.patch,*.rej,*.diff   syntax enable
augroup END
" OR ELSE use the filetype mechanism to select automatically...
filetype on
augroup PatchDiffHighlight
    autocmd!
    autocmd FileType diff   syntax enable
augroup END
" ----[ Open file with existing swp in readonly mode ]--------- {{{2
augroup NoSimultaneousEdits
    autocmd!
    autocmd SwapExists * let v:swapchoice = 'o'
    autocmd SwapExists * echomsg
    autocmd SwapExists * echo 'Duplicate edit session (readonly)'
    autocmd SwapExists * echohl None
    autocmd SwapExists * sleep 2
augroup END
" ----[ IncHeader ]-------------------------------------------------- {{{2
fun! IncHeader()
    let date = strftime("%B %d, %Y")
    call append(0, "" . "")
    call append(0, "/*" . "")
    call append(1, " * " . "Sullivan, Ryan")
    call append(2, " *" . "")
    call append(3, " * " . "CS A250")
    call append(4, " * " . date)
    call append(5, " *" . "")
    call append(6, " * " . "Lab ")
    call append(7, " */" . "")
endfun
" ----[ CycleLang ]------------------------------ {{{2
fun! CycleLang()
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
" ----[ file Encoding ]-------------------------------------------- {{{2
fun! ViewUTF8()
    set encoding=utf-8
    set termencoding=big5
endfun

fun! UTF8()
    set encoding=utf-8
    set termencoding=big5
    set fileencoding=utf-8
    set fileencodings=big5,utf-8
endfun

fun! Big5()
    set encoding=big5
    set fileencoding=big5
endfun
" ----[ Extended Text Objects ]----------------------------------------- {{{2
let s:items = [ "<bar>", "\\", "/", ":", ".", "*", "_" ]
for item in s:items
    exe "nnoremap yi".item." T".item."yt".item
    exe "nnoremap ya".item." F".item."yf".item
    exe "nnoremap ci".item." T".item."ct".item
    exe "nnoremap ca".item." F".item."cf".item
    exe "nnoremap di".item." T".item."dt".item
    exe "nnoremap da".item." F".item."df".item
    exe "nnoremap vi".item." T".item."vt".item
    exe "nnoremap va".item." F".item."vf".item
endfor
" ----[ Smart Tab Complete ]--------------------------------------------{{{2
function! Smart_TabComplete()
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
