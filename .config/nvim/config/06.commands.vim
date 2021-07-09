" ========{ Commands }================================================== " {{{1
autocmd! bufwritepost init.vim source ~/.config/nvim/init.vim " auto reload vimrc when editing it

" find cmd, fzf w/rp
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

autocmd FileType perl set autoindent|set smartindent|syntax on
" turn on list chars for dotfiles and notes
" folds
command! -nargs=+ Foldsearch exe "normal /".<q-args>."^M" | setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\|\|(getline(v:lnum+1)=~@/)?1:2 foldmethod=expr foldlevel=0 foldcolumn=2
" Notes & Pandoc
let g:semester = system('echo -n "$SEMESTER"')
command! -nargs=1 Note exe "e! " . fnameescape($NOTES_DIR . "/" . $YEAR . "/" . $SEMESTER . "/<args>.md")
command! -nargs=1 Ngrep lvimgrep "<args>" $NOTES_DIR/**/*.md
augroup markdown
    au!
    au BufRead,BufNewFile,BufEnter   $NOTES_DIR/*/*.txt let &complete="$NOTES_DIR/**/*.txt"
    au BufRead,BufNewFile,BufEnter   $NOTES_DIR/*/*.txt lcd %:h
    "au BufRead,BufWrite,InsertChange $NOTES_DIR/*/*.txt syn match ErrorMsg '\%>79v.\+'
    au Filetype rmd map <C-c> :!echo<space>"require(rmarkdown);<space>render('<c-r>%')"<space>\|<space>R<space>--vanilla<enter>
augroup end

command! -complete=file -nargs=1 Rpdf :r !pdftotext -nopgbrk <q-args> -
command! -complete=file -nargs=1 Rpdf :r !pdftotext -nopgbrk <q-args> - |fmt -csw78

" Extended Text Objects
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

" Open file with existing swp in readonly mode
augroup NoSimultaneousEdits
    autocmd!
    autocmd SwapExists * let v:swapchoice = 'o'
    autocmd SwapExists * echomsg
    autocmd SwapExists * echo 'Duplicate edit session (readonly)'
    autocmd SwapExists * echohl None
    autocmd SwapExists * sleep 2
augroup END

" grep word under cursor
command! -nargs=+ -complete=custom,s:GrepArgs Rg exe 'CocList grep '.<q-args>

" augroup lLength
"   autocmd BufEnter * highlight OverLength ctermbg=11 ctermfg=9 guibg=11
"   autocmd BufEnter * match OverLength /\%79v.*/
" augroup END

command! -nargs=0 Format :call CocAction('format')

"  smart tab complete
au FileType erl inoremap <tab> <c-r>=myfuncs#Smart_TabComplete()<CR>

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json,cpp,c,python,rust,go setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
