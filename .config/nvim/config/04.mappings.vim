"nnoremap <F2> <Plug>(dirvish_up)<CR>

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

" simply fold
let g:SimpylFold_docstring_preview=1

" Gitgutter setup
let g:gitgutter_realtime=0

" Customize fzf colors to match your color scheme
let g:skim_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:skim_history_dir = '~/.local/share/skim-history'

"fugitive
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gp :Git push<CR>
nnoremap <silent> <leader>gw :Gwrite<CR>
nnoremap <silent> <leader>gr :Gremove<CR>
autocmd FileType gitcommit nmap <buffer> U :Git checkout -- <C-r><C-g><CR>
autocmd BufReadPost fugitive://* set bufhidden=delete

" let g:undotree_WindowLayout='botright'
let g:undotree_SetFocusWhenToggle=1
"nnoremap <silent> <F1> :UndotreeToggle<CR>

" Golden view
let g:goldenview__enable_default_mapping=0
nmap <F7> <Plug>ToggleGoldenViewAutoResize

"Vim Startify setup
let g:startify_session_dir = '~/.cache/dein/sessions'
let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   MRU']            },
          \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ { 'type': 'commands',  'header': ['   Commands']       },
          \ ]
" gtags/ctags
let g:gen_tags#gtags_auto_gen = 1
let g:gen_tags#ctags_auto_gen = 1

" Path to store the cscope files (cscope.files and cscope.out)
" Defaults to '~/.cscope'
let g:cscope_dir = '~/.cache/nvim-cscope'

" Map the default keys on startup
" These keys are prefixed by CTRL+\ <cscope param>
" A.e.: CTRL+\ d for goto definition of word under cursor
" Defaults to off
let g:cscope_map_keys = 1

" Update the cscope files on startup of cscope.
" Defaults to off
let g:cscope_update_on_start = 1

"call CScopeMapKeys()

" rainbow
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle

let g:rainbow_load_separately = [
            \ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
            \ [ '*.tex' , [['(', ')'], ['\[', '\]']] ],
            \ [ '*.cpp' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
            \ [ '*.{html,htm}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
            \ ]

let g:rainbow_conf = {
            \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
            \   'ctermfgs': ['6', '5', '14', '3', '13', '2', '9'],
            \   'operators': '_,_',
            \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
            \   'separately': {
            \           '*': {},
            \           'tex': {
            \                   'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
            \           },
            \           'lisp': {
            \                   'guifgs': ['6', '5', '14', '3', '13', '2', '12', '4', '11', '9', '8', '7'],
            \           },
            \           'vim': {
            \                   'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
            \           },
            \           'html': {
            \                   'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
            \           },
            \           'css': 0,
            \   }
            \}
