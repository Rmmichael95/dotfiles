" ========{ Commands }================================================== " {{{1

autocmd! bufwritepost init.vim source ~/.config/nvim/init.vim " auto reload vimrc when editing it
" Enable omni completion. (Ctrl-X Ctrl-O)
" augroup omnifuncs
"     autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"     autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"     autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"     autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
"     autocmd FileType css set omnifunc=csscomplete#CompleteCSS
"     autocmd FileType c,cpp set omnifunc=ccomplete#Complete
"     autocmd FileType java set omnifunc=javacomplete#Complete
"     autocmd FileType java setlocal omnifunc=javacomplete#Complete
" augroup end

" tern
if exists('g:plugs["tern_for_vim"]')
    let g:tern_show_argument_hints = 'on_hold'
    let g:tern_show_signature_in_pum = 1
    autocmd FileType javascript setlocal om6nifunc=tern#Complete
endif
" Recognize mathmatica files
autocmd BufNewFile,BufRead *.wl set filetype=mma
autocmd BufNewFile,BufRead *.wls set filetype=mma
" make CSS omnicompletion work for SASS and SCSS
autocmd BufNewFile,BufRead *.scss             set ft=scss.css
autocmd BufNewFile,BufRead *.sass             set ft=sass.css
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
    au BufNewFile,BufRead,BufWrite   *.txt,*.md,*.mkd,*.markdown,*.mdwn setl ft=rmd
    au BufRead,BufNewFile,BufEnter   $NOTES_DIR/*/*.txt let &complete="$NOTES_DIR/**/*.txt"
    au BufRead,BufNewFile,BufEnter   $NOTES_DIR/*/*.txt lcd %:h
    "au BufRead,BufWrite,InsertChange $NOTES_DIR/*/*.txt syn match ErrorMsg '\%>79v.\+'
    au Filetype rmd map <C-c> :!echo<space>"require(rmarkdown);<space>render('<c-r>%')"<space>\|<space>R<space>--vanilla<enter>
augroup end

command! -complete=file -nargs=1 Rpdf :r !pdftotext -nopgbrk <q-args> -
command! -complete=file -nargs=1 Rpdf :r !pdftotext -nopgbrk <q-args> - |fmt -csw78

" augroup lLength
"   autocmd BufEnter * highlight OverLength ctermbg=11 ctermfg=9 guibg=11
"   autocmd BufEnter * match OverLength /\%79v.*/
" augroup END

