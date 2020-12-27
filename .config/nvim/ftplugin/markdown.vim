if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

au BufRead,BufNewFile,BufEnter   $NOTES_DIR/*/*.txt let &complete="$NOTES_DIR/**/*.txt"
au BufRead,BufNewFile,BufEnter   $NOTES_DIR/*/*.txt lcd %:h
"au BufRead,BufWrite,InsertChange $NOTES_DIR/*/*.txt syn match ErrorMsg '\%>79v.\+'
au Filetype rmd map <C-c> :!echo<space>"require(rmarkdown);<space>render('<c-r>%')"<space>\|<space>R<space>--vanilla<enter>

setlocal spell
setlocal spellsuggest
set textwidth=79
setlocal formatexpr=

" Personal preference, I like to see the formatting modifiers
setlocal conceallevel=0

" Don't enable spell check for documentation windows from coc
augroup noPreviewSpell
    autocmd!
    autocmd BufRead,BufNewFile,BufEnter,BufLeave coc://document setlocal nospell
augroup END
