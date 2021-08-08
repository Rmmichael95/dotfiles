local cmd = vim.cmd

cmd('command! -nargs=+ Foldsearch exe "normal /".<q-args>."^M" | setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\|\|(getline(v:lnum+1)=~@/)?1:2 foldmethod=expr foldlevel=0 foldcolumn=2')
cmd('command! -nargs=1 Ngrep lvimgrep "<args>" $NOTES_DIR/**/*.txt')
cmd('command! -range=% Rst :'<,'>!pandoc -f markdown -t rst')
