f exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

au BufRead,BufNewFile,BufEnter   $NOTES_DIR/*/*.txt let &complete="$NOTES_DIR/**/*.txt"
au BufRead,BufNewFile,BufEnter   $NOTES_DIR/*/*.txt lcd %:h
"au BufRead,BufWrite,InsertChange $NOTES_DIR/*/*.txt syn match ErrorMsg '\%>79v.\+'
au Filetype rmd map <C-c> :!echo<space>"require(rmarkdown);<space>render('<c-r>%')"<space>\|<space>R<space>--vanilla<enter>
