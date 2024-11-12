local cmd = vim.cmd

-- cmd([[command! -nargs=+ Foldsearch exe "normal /".<q-args>."^M" | setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\|\|(getline(v:lnum+1)=~@/)?1:2 foldmethod=expr foldlevel=0 foldcolumn=2]])
-- cmd([[command! -nargs=1 Ngrep lvimgrep "<args>" $NOTES_DIR/**/*.txt]])
-- cmd([[command! -range=% Rst :'<,'>!pandoc -f markdown -t rst]])

cmd([[command! -bang -nargs=* Ag call fzf#vim#ag_interactive(<q-args>, fzf#vim#with_preview('right:50%:hidden', 'alt-h'))]])
cmd([[command! -bang -nargs=* Rg call fzf#vim#rg_interactive(<q-args>, fzf#vim#with_preview('right:50%:hidden', 'alt-h'))]])

-- vertically center document when entering insert mode
cmd('autocmd InsertEnter * norm zz')

-- highlight whitespace before tabs and eol in darkred
cmd('highlight ExtraWhitespace guibg=darkred')
cmd([[autocmd BufEnter * match ExtraWhitespace /\s\+$\| \+\ze\t/]])
cmd('autocmd FileType dashboard highlight ExtraWhitespace guibg=0')
