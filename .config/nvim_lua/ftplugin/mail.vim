" mail.vim
" Sets the formatexpr to the default, and textwidth to 79 for automatic
" wrapping in plaintext emails
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1
set tw=72
setlocal formatexpr=
setlocal textwidth=79
setlocal spell
setlocal spellsuggest
