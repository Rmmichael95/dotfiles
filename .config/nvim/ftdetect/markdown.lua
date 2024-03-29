local u = require('utils')

u.create_augroup({
    { 'BufRead,BufNewFile', '/tmp/calcurse*,~/.calcurse/notes/*', 'set', 'ft=markdown' },
    { 'BufRead,BufNewFile', '*.md,*.md.html,*.mmark', 'set', 'filetype=markdown' },
    { 'BufRead,BufNewFile', '*.md', 'set', 'filetype=markdown' },
--  rmarkdown
    { 'BufRead,BufNewFile', '*.rmd', 'set', 'filetype=rmd' }
}, 'filetypedetect')
