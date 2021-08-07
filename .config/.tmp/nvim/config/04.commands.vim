" ========{ Commands }================================================== " {{{1
autocmd! bufwritepost init.vim source ~/.config/nvim/init.vim " auto reload vimrc when editing it

" turn on list chars for dotfiles and notes
" folds
command! -nargs=+ Foldsearch exe "normal /".<q-args>."^M" | setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\|\|(getline(v:lnum+1)=~@/)?1:2 foldmethod=expr foldlevel=0 foldcolumn=2

command! -nargs=1 Ngrep lvimgrep "<args>" $NOTES_DIR/**/*.txt

command! -range=% Rst :'<,'>!pandoc -f markdown -t rst

nnoremap 'ms :w!<cr>:exe "!pandoc -t beamer -o " . fnameescape(expand('%:p:r')) . ".pdf " . fnameescape(expand('%:p'))<cr>
nnoremap 'mh :w!<cr>:exe "!pandoc --pdf-engine=lualatex -H ~/.config/pandoc/fonts.tex -o " . fnameescape(expand('%:p:r')) . ".pdf " . fnameescape(expand('%:p'))<cr>
nnoremap 'md :w!<cr>:exe "!pandoc --pdf-engine=lualatex -H ~/.config/pandoc/fonts.tex -o $HOME/" . fnameescape(expand('%:t:r')) . ".pdf " . fnameescape(expand('%:p'))<cr>
nnoremap 'mp :w!<cr>:exe "!pandoc --pdf-engine=lualatex -H ~/.config/pandoc/fonts.tex -o /tmp/" . fnameescape(expand('%:t:r')) . ".pdf " . fnameescape(expand('%:p')) . " && xdg-open /tmp/" . fnameescape(expand('%:t:r')) . ".pdf"<cr>

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

" Vertically center document when entering insert mode
autocmd InsertEnter * norm zz

highlight ExtraWhitespace guibg=darkred ctermbg=darkred
autocmd BufEnter * match ExtraWhitespace /\s\+$\| \+\ze\t/
