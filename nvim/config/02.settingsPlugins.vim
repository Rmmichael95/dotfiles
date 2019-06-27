" ========{ Plugin Settings }================================================== " {{{1

" auto install new plugins
if dein#check_install()
    call dein#install()
endi

"set rtp+=/home/ryanm/.nvim/bundles/repos/github.com/dbgx/lldb.nvim

" ----[ General Plugin Settings ]---------- {{{2
" Gitgutter setup
let g:gitgutter_realtime=0

" netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
"let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

" simply fold
let g:SimpylFold_docstring_preview=1
" ----[ Language specific ]---------------- {{{2
" C-support
let  g:C_UseTool_cmake    = 'yes'
let  g:C_UseTool_doxygen = 'yes'
" Doxygen
let g:DoxygenToolkit_briefTag_pre="@Synopsis"
let g:DoxygenToolkit_paramTag_pre="@Param"
let g:DoxygenToolkit_returnTag="@Returns"
let g:DoxygenToolkit_blockHeader="--------------------------------------------------------------------------"
let g:DoxygenToolkit_blockFooter="--------------------------------------------------------------------------"
let g:DoxygenToolkit_authorName="Ryan M Sullivan"
let g:DoxygenToolkit_licenseTag="My license"
" Python
autocmd BufWinEnter *.py setlocal foldexpr=SimpylFold(v:lnum) foldmethod=expr
autocmd BufWinLeave *.py setlocal foldexpr< foldmethod<
" markdown
let g:vim_markdown_conceal = 0
let g:vim_markdown_math = 0
" ----[ Ctags ]---------------------------- {{{2
let g:vim_tags_auto_generate = 1
let g:vim_tags_use_language_field = 1
let g:vim_tags_main_file = 'tags'
" lh-tags
"au BufWritePost *.c,*.cpp,*.h silent! !ctags -R &
" ----[ Cscope ]--------------------------- {{{2
" s: Find this C symbol
nnoremap  <leader>fs :call cscope#find('s', expand('<cword>'))<CR>
" g: Find this definition
nnoremap  <leader>fg :call cscope#find('g', expand('<cword>'))<CR>
" d: Find functions called by this function
nnoremap  <leader>fd :call cscope#find('d', expand('<cword>'))<CR>
" c: Find functions calling this function
nnoremap  <leader>fc :call cscope#find('c', expand('<cword>'))<CR>
" t: Find this text string
nnoremap  <leader>ft :call cscope#find('t', expand('<cword>'))<CR>
" e: Find this egrep pattern
nnoremap  <leader>fe :call cscope#find('e', expand('<cword>'))<CR>
" f: Find this file
nnoremap  <leader>ff :call cscope#find('f', expand('<cword>'))<CR>
" i: Find files #including this file
nnoremap  <leader>fi :call cscope#find('i', expand('<cword>'))<CR>
" ----[ Deoplete ]-----------------------------------------------{{{2
" deoplete options
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1

" disable autocomplete by default
" let b:deoplete_disable_auto_complete=1
" let g:deoplete_disable_auto_complete=1

call deoplete#custom#source('LanguageClient',
            \ 'min_pattern_length',
            \ 2)

if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
endif

" Disable the candidates in Comment/String syntaxes.
call deoplete#custom#source('_',
            \ 'disabled_syntaxes', ['Comment', 'String'])

autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

call deoplete#custom#option('sources', {
            \ 'c': ['LanguageClient'],
            \ 'cpp': ['LanguageClient'],
            \ 'python': ['LanguageClient'],
            \ 'python3': ['LanguageClient'],
            \ 'go': ['LanguageClient'],
            \ 'ruby': ['LanguageClient'],
            \ 'java': ['LanguageClient'],
            \ 'javascript': ['LanguagClient'],
            \ 'haskell': ['LanguageClient'],
            \ 'php': ['LanguageClient'],
            \ 'html': ['LanguageClient'],
            \ 'css': ['LanguageClient'],
            \ 'lua': ['LanguageClient'],
            \ 'json': ['LanguageClient'],
            \ 'yaml': ['LanguageClient'],
            \ 'vim': ['vim'],
            \})

" ignored sources
let g:deoplete#ignore_sources = {}
let g:deoplete#ignore_sources._ = ['buffer', 'around']

" ----[ Language Client ]----------------------------------------{{{2
" language server commands
let g:LanguageClient_serverCommands = {
            \ 'c': ['cquery'],
            \ 'cpp': ['cquery'],
            \ 'python': ['/home/ryanm/.virtualenvs/csA131_env/bin/pyls', '--log-file', '/tmp/pyls.log'],
            \ 'go': ['go-langserver', 'gocodecomplete', 'freeosmemory', 'false'],
            \ 'ruby': ['solargraph', 'stdio'],
            \ 'java': ['jdtls'],
            \ 'javascript': ['javascript-typescript-stdio'],
            \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
            \ 'haskell': ['hie-wrapper'],
            \ 'php': ['php-language-server'],
            \ 'html': ['html-languageserver'],
            \ 'css': ['css-languageserver'],
            \ 'lua': ['emmylua-language-server'],
            \ 'json': ['json-languageserver'],
            \ 'yaml': ['yaml-language-server'],
            \ }
let g:LanguageClient_autoStart = 1
let g:LanguageClient_rootMarkers = {
            \ 'cpp': ['compile_commands.json', 'make'],
            \ 'c': ['compile_commands.json', 'make'],
            \ 'haskell': ['*.cabal', 'stack.yaml'],
            \ }

set completefunc=LanguageClient#complete
set formatexpr=LanguageClient_textDocument_rangeFormatting()

let g:LanguageClient_loadSettings = 1
let g:LanguageClient_settingsPath = '/home/ryanm/.config/nvim/settings.json'
" ----[ ALE ]----------------------------------------------------{{{2
" Disable completion where available from ALE
" (not worth creating a separate file just for a one-liner)
let g:ale_completion_enabled = 0

" Only run linters named in ale_linters settings.
let g:ale_linters_explicit = 1
" ----[ fzf ]------------------------------ {{{2
" Customize fzf colors to match your color scheme
let g:fzf_colors =
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
let g:fzf_history_dir = '~/.local/share/fzf-history'
" ----[ vim-tags ]------------------------- {{{2
let g:vim_tags_auto_generate = 1
" ----[ Undotree setup ]----------------------- {{{4
" let g:undotree_WindowLayout='botright'
let g:undotree_SetFocusWhenToggle=1
nnoremap <silent> <F5> :UndotreeToggle<CR>
" ----[ GoldenView setup ]--------------------- {{{2
let g:goldenview__enable_default_mapping=0
nmap <F4> <Plug>ToggleGoldenViewAutoResize
" ----[ Startify Configuration ]---------------------- {{{2
"|g:autoloaded_startify|
"g:startify_bookmarks|
"g:startify_change_to_dir|
"g:startify_change_to_vcs_root|
"g:startify_custom_footer|
"g:startify_custom_header|
"g:startify_custom_indices|
"g:startify_disable_at_vimenter|
"g:startify_enable_special|
"g:startify_enable_unsafe|
"g:startify_files_number|
"g:startify_list_order|
"g:startify_relative_path|
"g:startify_session_autoload|
"g:startify_session_delete_buffers|
"g:startify_session_dir|
"let g:startify_session_dir = '~/.vim/session'
"g:startify_session_persistence|
"g:startify_session_savecmds|
"g:startify_session_savevars|
"g:startify_skiplist_server|
"g:startify_skiplist|
"Vim Startify setup
"let g:startify_session_dir = g:vimDir.'/.cache/sessions'
"let g:startify_change_to_vcs_root = 1
"let g:startify_show_sessions = 1
"nnoremap <F1> :Startify<cr>
" ----[ Rainbow setup ]-------------------------------- {{{2
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
" ----[ Vim Markdown ]
" syntax highlighting for latex blocks in markdown
let g:vim_markdown_math = 1

" YAML syntax highlighting for frontmatter
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_follow_anchor = 1
let g:vim_markdown_fenced_languages = ['csharp=cs', 'cpp=cpp', 'c=c', 'rust=rust', 'python=python', 'sh=sh', 'html=html', 'md=markdown']
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_conceal = 0

let g:UltiSnipsEditSplit="vertical"

" ----[ Pandoc setup ]-------------------------- {{{2
let g:pandoc_use_conceal = 1
let g:pandoc_syntax_dont_use_conceal_for_rules = ['block', 'codeblock_start', 'codeblock_delim']
let g:pandoc_syntax_user_cchars = {'li': '*'}
let g:pantondoc_use_pandoc_markdown = 1
"let g:pandoc#formatting#equalprg = \"pandoc -t markdown --no-wrap --atx-headers"
" ----[ eclim ]-------------------------------- {{{2
"Run Checkstyle on open/write
set rtp^=/usr/share/vim/vimfiles/
autocmd BufWinEnter *.java :Checkstyle
autocmd BufWritePost *.java :Checkstyle
let g:EclimCompletionMethod = 'omnifunc'
" ----[ Neogdb ]---------------------------------------- {{{2
let g:neobugger_leader = ';'
nmap <Space>p :call neobugger#gdb#Send("print " . expand('<cword>'))<CR>

function! NeogdbvimNmapCallback()
    " Let fzf.vim open files in the current window by default.
    " This is so that, when navigating files,
    " we don't switch to a new tab and thus *always* see the neogdb's splits.
    let g:fzf_action = { 'enter': 'edit' }
endfunc

function! NeogdbvimUnmapCallback()
    " Quitting to normal editing. Let fzf.vim open files in the new tab,
    " as usual.
    let g:fzf_action = { 'enter': 'tabnew' }
endfunc

let g:neogdb_window = ['breakpoint', 'backtrace']
" ----[ Fugitive setup ]-------------------- {{{2
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
" ----[ Vim-Multiple-Cursors ]---------- {{{2
" Default mapping
"let g:multi_cursor_next_key='<C-n>'
"let g:multi_cursor_prev_key='<C-p>'
"let g:multi_cursor_skip_key='<C-x>'
"let g:multi_cursor_quit_key='<Esc>'
" Called once right before you start selecting multiple cursors
function! Multiple_cursors_before()
    if exists(':NeoCompleteLock')==2
        exe 'NeoCompleteLock'
    endif
endfunction
" Called once only when the multiple selection is canceled (default <Esc>)
function! Multiple_cursors_after()
    if exists(':NeoCompleteUnlock')==2
        exe 'NeoCompleteUnlock'
    endif
endfunction
" Default highlighting
highlight multiple_cursors_cursor term=reverse cterm=reverse gui=reverse
highlight link multiple_cursors_visual Visual
" ----[ Airline ]---------------------- {{{2
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = 'ב'
let g:airline_symbols.linenr = 'ג'
let g:airline_symbols.linenr = '≓'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = 'Ξ'
let g:airline_symbols.maxlinenr = '☰'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = '␣'
" LanguageClient
let g:airline#extensions#languageclient#enabled = 1
let airline#extensions#languageclient#error_symbol = 'E:'
let airline#extensions#languageclient#warnng_symbol = 'W:'
let airline#extensions#languageclient#show_line_numbers = 1
let airline#extensions#languageclient#open_lnum_symbol = '(L'
let airline#extensions#languageclient#close_lnum_symbol = ')'
" localsearch
let g:airline#extensions#localsearch#enabled = 1
