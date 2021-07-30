" CoC
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gc :call CocAction('format')<CR>
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>rf <Plug>(coc-references)

" fzy
nnoremap <C-p> :CocList files<Cr>
nnoremap <C-s> :CocList grep<CR>
nnoremap <C-m> :CocList marks<CR>

" Keymapping for grep word under cursor with interactive mode
nnoremap <silent> <Leader>cf :exe 'CocList -I --input='.expand('<cword>').' grep'<CR>
nnoremap <silent> <space>w  :exe 'CocList -I --normal --input='.expand('<cword>').' words'<CR>

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)
