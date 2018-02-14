" Maintainer: Ryan M Sullivan
" Last Change: February 5, 2018
" ------------------------------------------------------------------------------
" Vim Configuration
" ------------------------------------------------------------------------ " {{{
" ========{ Plugins }===================================================== " {{{

if has('nvim')
    runtime! python_setup.vim
endif

" --------[ Dein ]------------------------------------ {{{

if &compatible
    set nocompatible
endif

set runtimepath+=/home/ryanm/.local/share/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('/home/ryanm/.nvim/bundles')
    call dein#begin('/home/ryanm/.nvim/bundles')
    call dein#add('/home/ryanm/.nvim/bundles/repos/github.com/Shougo/dein.vim')
    call dein#add('Shougo/dein.vim')
    call dein#add('Shougo/deoplete.nvim', {'on_ft':['cpp', 'c', 'java', 'rd', 'pl', ]})
    call dein#add('zchee/deoplete-clang', {'on_ft':['cpp', 'c']})
    call dein#add('zchee/libclang-python3')
    call dein#add('Shougo/neco-vim')
    call dein#add('Shougo/neoinclude.vim')
    call dein#add('artur-shaik/vim-javacomplete2', {'on_ft':['java']})
    call dein#add('zchee/deoplete-jedi', {'on_ft':['py']})
    call dein#add('davidhalter/jedi')
    call dein#add('cyansprite/omnisharp.nvim', {'build':['./install.sh']})
    call dein#add('ternjs/tern_for_vim', {'build':['npm install']})
    call dein#add('starcraftman/vim-eclim', {'on_ft':'java'})
    call dein#add('tpope/vim-endwise')
    call dein#add('tpope/vim-commentary')
    call dein#add('tpope/vim-repeat')
    call dein#add('tpope/vim-dispatch')
    call dein#add('radenling/vim-dispatch-neovim')
    call dein#add('tpope/vim-fugitive')
    call dein#add('tpope/vim-surround')
    call dein#add('tpope/vim-sensible')
    call dein#add('jiangmiao/auto-pairs')
    call dein#add('neomake/neomake')
    call dein#add('godlygeek/tabular', {'on_cmd':['Tabularize']})
    call dein#add('jeffkreeftmeijer/vim-numbertoggle')
    call dein#add('ntpeters/vim-better-whitespace')
    call dein#add('christoomey/vim-tmux-navigator')
    call dein#add('easymotion/vim-easymotion')
    call dein#add('wincent/ferret')
    call dein#add('powerman/vim-plugin-viewdoc')
    call dein#add('SirVer/ultisnips')
    call dein#add('honza/vim-snippets')
    call dein#add('jgdavey/tslime.vim')
    call dein#add('benmills/vimux')
    call dein#add('qpkorr/vim-bufkill')
    call dein#add('mhinz/vim-startify')
    call dein#add('luochen1990/rainbow')
    call dein#add('editorconfig/editorconfig-vim')
    call dein#add('terryma/vim-multiple-cursors')
    call dein#add('chrisbra/NrrwRgn')
    call dein#add('tmhedberg/SimpylFold')
    call dein#add('tpope/vim-sleuth')
    "call dein#add('vim-scripts/L9')
    "call dein#add('sheerun/vim-polyglot')
    call dein#add('dhruvasagar/vim-table-mode')
    call dein#add('vim-airline/vim-airline')
    call dein#add('vim-airline/vim-airline-themes')
    call dein#add('kien/ctrlp.vim')
    call dein#add('Shougo/vimproc.vim', {'build':['make']})
    call dein#add('mbbill/undotree', {'on_cmd':['UndotreeToggle']})
    call dein#add('scrooloose/nerdtree', {'on_cmd':['NERDTreeToggle','NERDTreeFind']})
    call dein#add('Xuyuanp/nerdtree-git-plugin', {'on_cmd':['<Plug>NERDTreeToggle','<Plug>NERDTreeFind']})
    call dein#add('zhaocai/GoldenView.Vim', {'on_cmd':'<Plug>ToggleGoldenViewAutoResize'})
    call dein#add('thoughtbot/vim-rspec', {'on_func':['RunCurrentSpecFile','RunNearestSpec', 'RunAllSpecs', 'RunLastSpec']})
    " Groovy
    call dein#add('vim-scripts/groovy.vim', {'on_ft':['groovy']})
    " Gradle
    call dein#add('tfnico/vim-gradle', {'on_ft':['gradle']})
    " Java
    call dein#add('Dinduks/vim-java-get-set', {'on_ft':['java']})
    " C++
    call dein#add('octol/vim-cpp-enhanced-highlight', {'on_ft':['cpp', 'c', 'h']})
    call dein#add('derekwyatt/vim-protodef', {'on_ft':['cpp', 'c', 'h']})
    call dein#add('derekwyatt/vim-fswitch', {'on_ft':['cpp', 'c']})
    call dein#add('vim-scripts/DoxygenToolkit.vim', {'on_ft':['cpp', 'c']})
    call dein#add('majutsushi/tagbar', {'on_cmd':['TagbarToggle']})
    call dein#add('szw/vim-tags', {'on_ft':['cpp', 'c']})
    " general refactoring
    call dein#add('derekwyatt/vim-protodef', {'on_ft':['cpp', 'c']})
    call dein#add('huawenyu/neogdb.vim', {'on_ft':['cpp', 'c']})
    "call dein#add('dbgx/lldb.nvim', {'on_ft':['cpp', 'c']})
    " Cscope
    call dein#add('vim-scripts/cscope.vim', {'on_ft':['cpp', 'c']})
    call dein#add('JCLiang/vim-cscope-utils', {'on_ft':['cpp', 'c']})
    " Markdown
    call dein#add('vim-pandoc/vim-pandoc-syntax', {'on_ft':['markdown', 'pandoc.markdown', 'rmd']})
    call dein#add('vim-pandoc/vim-pantondoc', {'on_ft':['markdown', 'pandoc.markdown', 'rmd']})
    call dein#add('shime/vim-livedown', {'on_ft':['markdown', 'pandoc.markdown', 'rmd']})
    call dein#add('PProvost/vim-markdown-jekyll', {'on_ft':['html', 'hbs', 'markdown', 'pandoc.markdown', 'rmd']})
    " tex
    call dein#add('xuhdev/vim-latex-live-preview', {'on_ft':['tex', 'rmd']})
    " Perl
    "call dein#add('vim-perl/vim-perl', {'build':['make clean carp dancer highlight-all-pragmas moose test-more try-tiny']})
    " Python
    call dein#add('klen/python-mode', {'on_ft':['python', 'py']})
    " Ruby
    call dein#add("tpope/vim-rails", {'on_ft':['ruby', 'rb']})
    call dein#add("vim-ruby/vim-ruby", {'on_ft':['ruby', 'rb']})
    call dein#add("tpope/vim-rake", {'on_ft':['ruby', 'rb']})
    call dein#add("tpope/vim-bundler", {'on_ft':['ruby', 'rb']})
    call dein#add("tpope/vim-cucumber", {'on_ft':['ruby', 'rb']})
    call dein#add("slim-template/vim-slim", {'on_ft':['slim']})
    " Web
    call dein#add('othree/html5.vim', {'on_ft':['html', 'html.handlebars']})
    call dein#add('cakebaker/scss-syntax.vim', {'on_ft':['less', 'scss', 'sass']})
    call dein#add('elzr/vim-json', {'on_ft':['json']})
    call dein#add('mustache/vim-mustache-handlebars', {'on_ft':['html', 'html.handlebars']})
    call dein#add("rstacruz/sparkup", {'on_ft':['html']})
    call dein#add("tpope/vim-haml", {'on_ft':['haml', 'hamlc', 'sass', 'scss']})
    call dein#add('jamessan/vim-gnupg', {'on_ft':['gpg', 'pgp', 'asc']})
    call dein#add('evidens/vim-twig', {'on_ft':['php']})

    call dein#end()
    call dein#save_state()
endif

filetype plugin indent on
syntax enable

" }}}
" --------[ Plugin Settings ]----------------------------------------------- {{{
"
" auto install new plugins
if dein#check_install()
    call dein#install()
endi

"set rtp+=/home/ryanm/.nvim/bundles/repos/github.com/dbgx/lldb.nvim

" --------[ General Plugin Settings ]---------- {{{
" Gitgutter setup
let g:gitgutter_realtime=0
" }}}
" --------[ Language specific ]---------------- {{{
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
" Markdown                                                                   \/ added this
autocmd BufRead,BufNewFile md,markdown setlocal filetype=pandoc.markdown \" Automatically set filetype for Markdown files"
" Python
autocmd BufWinEnter *.py setlocal foldexpr=SimpylFold(v:lnum) foldmethod=expr
autocmd BufWinLeave *.py setlocal foldexpr< foldmethod<
" }}}
" --------[ Ctags ]---------------------------- {{{
let g:vim_tags_auto_generate = 1
let g:vim_tags_use_language_field = 1
let g:vim_tags_main_file = 'tags'
" lh-tags
"au BufWritePost *.c,*.cpp,*.h silent! !ctags -R &
" }}}
" --------[ Cscope ]--------------------------- {{{
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
" }}}
" --------[ Deoplete ]---------------------- {{{
set rtp+=/home/ryanm/repos/github.com/Shougo/deoplete.nvim/
let g:deoplete#enable_at_startup = 1
" c++
let g:deoplete#sources#clang#libclang_path="/usr/lib/libclang.so"
let g:deoplete#sources#clang#clang_header="/usr/lib/clang"
" omnisharp
let g:deoplete_omnisharp_exe_path   = get(g:, "deoplete_omnisharp_exe_path", '~/.nvim/bundles/repos/github.com/cyansprite/omnisharp.nvim/omnisharp-server/OmniSharp/bin/Debug/OmniSharp.exe')
let g:deoplete_omnisharp_port   = get(g:, "deoplete_omnisharp_port", 9999)
" }}}
" --------[ Neomake ]-------------------------- {{{
" When writing a buffer.
call neomake#configure#automake('w')
" When writing a buffer, and on normal mode changes (after 1s).
"call neomake#configure#automake('nw', 1000)
" When reading a buffer (after 750ms), and when writing.
"call neomake#configure#automake('rw', 750)
" }}}
" --------[ Undotree setup ]----------------------- {{{
" let g:undotree_WindowLayout='botright'
let g:undotree_SetFocusWhenToggle=1
nnoremap <silent> <F5> :UndotreeToggle<CR>
" }}}
" --------[ NERDTree setup ]------------------------ {{{
let NERDTreeShowHidden=0
let NERDTreeQuitOnOpen=0
let g:NERDTreeUseSimpleIndicator=1
let NERDTreeShowLineNumbers=1
let NERDTreeChDirMode=2
let NERDTreeShowBookmarks=0
let NERDTreeIgnore=['\.hg', '.DS_Store']
"let NERDTreeBookmarksFile=expand(g:vimDir.'/.cache/NERDTree/NERDTreeBookmarks')
nnoremap <F2> :NERDTreeToggle<CR>
"nnoremap <F3> :NERDTreeFind<CR>
" }}}
" --------[ GoldenView setup ]--------------------- {{{
let g:goldenview__enable_default_mapping=0
nmap <F4> <Plug>ToggleGoldenViewAutoResize
" }}}
" --------[ UltiSnips setup ]---------------------- {{{
let g:UltiSnipsExpandTrigger='<c-x>'
let g:UltiSnipsJumpForwardTrigger='<c-l>'
let g:UltiSnipsJumpBackwardTrigger='<c-h>'
let g:UltiSnipsSnippetDirectorie=$HOME.'/.nvim/UltiSnips'
" }}}
" --------[ Tex Live Preview ]------------------------------- {{{
let g:livepreview_previewer = 'zathura'
" }}}
" --------[ RSpec.vim mappings ]----------------------- {{{
map <Leader>rs :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
let g:rspec_command = "Dispatch rspec {spec}"
" }}}
"--------[ Startify Configuration ]---------------------- {{{
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
" }}}
" ------- [ Rainbow setup ]-------------------------------- {{{
syntax on
let g:rainbow_active = 1

let g:rainbow_load_separately = [
            \ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
            \ [ '*.tex' , [['(', ')'], ['\[', '\]']] ],
            \ [ '*.cpp' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
            \ [ '*.{html,htm}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
            \ ]

"au FileType c,cpp,h,objc,objcpp,python,java,javascript call rainbow#load()
au VimEnter call rainbow#load()
let g:rainbow_conf = {
            \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
            \   'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
            \   'operators': '_,_',
            \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
            \   'separately': {
            \       '*': {},
            \       'tex': {
            \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
            \       },
            \       'lisp': {
            \           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
            \       },
            \       'vim': {
            \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
            \       },
            \       'html': {
            \           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
            \       },
            \       'css': 0,
            \   }
            \}
" }}}
" --------[ Pandoc setup ]-------------------------- {{{
let g:pandoc_use_conceal = 1
let g:pandoc_syntax_dont_use_conceal_for_rules = ['block', 'codeblock_start', 'codeblock_delim']
let g:pandoc_syntax_user_cchars = {'li': '*'}
let g:pantondoc_use_pandoc_markdown = 1
"let g:pandoc#formatting#equalprg = \"pandoc -t markdown --no-wrap --atx-headers"
" }}}
" --------[ Livedown setup ]----------------------- {{{
let g:livedown_autorun = 0
let g:livedown_open = 1
let g:livedown_port = 1337
" }}}
" --------[ eclim ]-------------------------------- {{{
"Run Checkstyle on open/write
set rtp^=/usr/share/vim/vimfiles/
autocmd BufWinEnter *.java :Checkstyle
autocmd BufWritePost *.java :Checkstyle
let g:EclimCompletionMethod = 'omnifunc'
" }}}
" --------[ Neogdb ]---------------------------------------- {{{
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

let g:neogdb_window = ['backtrace', 'breakpoint']
" }}}
" --------[ Fugitive setup ]-------------------- {{{
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
" }}}
" --------[ Vim-Multiple-Cursors ]---------- {{{
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
" }}}
" --------[ Airline ]---------------------- {{{
let g:airline_theme='mine'

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
  " unicode symbols
  let g:airline_left_sep = '»'
  let g:airline_left_sep = '▶'
  let g:airline_right_sep = '«'
  let g:airline_right_sep = '◀'
  let g:airline_symbols.crypt = 'Ǣ'
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
" }}}
" }}}
" }}}
" ========{ Formatting }================================================== " {{{
set backup
set backupskip=/tmp/*,/private/tmp/*",*.gpg
set backupdir=~/.nvim/tmp,/tmp
set browsedir=buffer
set directory=~/.nvim/tmp,/tmp"
set history=10000
"set autochdir
set mouse=a
set number
set ruler
set showcmd
set hlsearch
set ignorecase
set smartcase
set showmatch
set autoindent
set laststatus=2
set hidden
set spelllang=en_us
set encoding=utf-8
set termencoding=big5
set fileencoding=utf-8
set fileencodings=big5,utf-8
set fileformat=unix
set fileformats=unix,dos,mac
set formatprg=par
set cursorline
set nowrap
set completeopt=longest,menuone
set cot -=preview
set wildmenu
set wildchar=<TAB>
set wildmode=list:longest,list:full
set wildignore=*.o,*.class,*.pyc
set timeoutlen=1000 ttimeoutlen=0
set noshowmode
set cmdheight=1
set visualbell t_vb=".
set tags=tags;
set fdm=marker
set splitbelow
set splitright
set shell=/bin/zsh
set omnifunc=syntaxcomplete#Complete
highlight LineNr ctermfg=grey " line number coloring
let perl_include_pod = 1 " my perl includes pod
let perl_extended_vars = 1 " syntax color complex things like @{${foo}}
" }}}
" ========{ Basic UI Configuration }====================================== " {{{
" --------[ Leaders ]---------------------------------------- {{{
map Q gq " Don't use Ex mode, use Q for formatting
let leader = "," " remap leader to z (from \)
let g:leader = "," " remap leader to z (global)
let  mapleader = "," " remap leader to , (from \)
let g:mapleader = "," " remap leader to z (global)
map <leader>r :source ~/.config/nvim/init.vim<cr>
set pastetoggle=<leader>P
nnoremap <leader>q :q!<cr>
nnoremap <leader>w :w<cr>
nnoremap <leader>z :wq!<cr>
nnoremap <leader>\ :TagbarToggle<CR>
nmap <silent> <leader>y :FSHere<cr>
" Notes
nnoremap <leader>N :Note
nnoremap <leader>[ :Ngrep
" }}}
" --------[ Plugin Maps ]------------------------------------------------ {{{
"  Vim protodef
"  pull defs to cursor <leader>PP
"  vim livedown
map <leader>gm :call LivedownPreview()<CR>
" lldb mapping
" map <leader>O :LLsession new<CR>
" map <leader>P :LLmode debug<CR>
" map <leader>L :LLmode code<CR>
" nmap <leader>F  <Plug>LLBreakSwitch
" map <leader>C :LL continue<CR>
" map <leader>M :LL step<CR>
" map <leader>N :LL next<CR>
" color break symbol
"hi LLBreakpointSign ctermfg=cyan
" vmap <F2> <Plug>LLStdInSelected
" nnoremap <F4> :LLstdin<CR>
" nnoremap <S-F8> :LL process interrupt<CR>
" nnoremap <F9> :LL print <C-R>=expand('<cword>')<CR>
" vnoremap <F9> :<C-U>LL print <C-R>=lldb#util#get_selection()<CR><CR>
"  dispatch
nnoremap <F9> :Dispatch<CR>

" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" tern
autocmd FileType javascript nnoremap <silent> <buffer> gb :TernDef<CR>

" Ferret
" |:Ack| search <leader>a
" |:Ack| search wd under cursor <leader>s

" Ultisnippts mapped in plugin settings
" g:UltiSnipsExpandTrigger='<c-x>'
" g:UltiSnipsJumpForwardTrigger='<c-j>'
" g:UltiSnipsJumpBackwardTrigger='<c-k>'

" }}}
" --------[ Mappings ]---------------------------------------- {{{
" Navigate Vim Splits
nnoremap <C-J> <C-W><C-J> "Ctrl-j to move down a split
nnoremap <C-K> <C-W><C-K> "Ctrl-k to move up a split
nnoremap <C-L> <C-W><C-L> "Ctrl-l to move    right a split
nnoremap <C-H> <C-W><C-H> "Ctrl-h to move left a split
" ,g generates the header guard
map <leader>g :call IncludeGuard()<CR> " func in other section
map <leader>h :call IncHeader()<CR>
" new tab
map <C-t><C-t> :tabnew<CR>
" close tab
map <C-t><C-z> :tabclose<CR>
" Bash like keys for the command line
cnoremap <C-A>      <Home>
cnoremap <C-E>      <End>
cnoremap <C-K> <C-U>
" allow multiple indentation/deindentation in visual mode
vnoremap < <gv
vnoremap > >gv
" :cd. change working directory t6o that of the current file
cmap cd. lcd %:p:h<cr>
" Notes & Pandoc

nnoremap 'ms :%norm A\<cr>
nnoremap 'mn :%norm $x<cr>
nnoremap 'mp :w!<cr>:exe "!pandoc --pdf-engine=lualatex -H ~/.config/pandoc/fonts.tex -o $HOME/" . fnameescape(expand('%:t:r')) . ".pdf " . fnameescape(expand('%:p'))<cr>
nnoremap 'mm :w!<cr>:exe "!pandoc --pdf-engine=lualatex -H ~/.config/pandoc/fonts.tex -o /tmp/" . fnameescape(expand('%:t:r')) . ".pdf " . fnameescape(expand('%:p')) . " && xdg-open /tmp/" . fnameescape(expand('%:t:r')) . ".pdf"<cr>
" Symbols ---------------------------------- {{{
" Greek
map! <C-s>A Α
map! <C-s>a α
map! <C-s>B Β
map! <C-s>b β
map! <C-s>G Γ
map! <C-s>g γ
map! <C-s>D Δ
map! <C-s>d δ
map! <C-s>E Ε
map! <C-s>e ε
map! <C-s>Z Ζ
map! <C-s>z ζ
map! <C-s>H Η
map! <C-s>h η
map! <C-s>T Θ
map! <C-s>t θ
map! <C-s>I Ι
map! <C-s>i ι
map! <C-s>K Κ
map! <C-s>k κ
map! <C-s>L Λ
map! <C-s>l λ
map! <C-s>M Μ
map! <C-s>m μ
map! <C-s>N Ν
map! <C-s>n ν
map! <C-s>C Ξ
map! <C-s>c ξ
map! <C-s>O Ο
map! <C-s>o ο
map! <C-s>P Π
map! <C-s>p π
map! <C-s>R Ρ
map! <C-s>r ρ
map! <C-s>S Σ
map! <C-s>s σ
map! <C-s>T Τ
map! <C-s>t τ
map! <C-s>U Υ
map! <C-s>u υ
map! <C-s>F Φ
map! <C-s>f φ
map! <C-s>X Χ
map! <C-s>x χ
map! <C-s>Y ψ
map! <C-s>y ψ
map! <C-s>W Ω
map! <C-s>w ω
" Math
map! <C-s>fa ∀
map! <C-s>te ∃
map! <C-s>(- ∈
map! <C-s>-) ∋
map! <C-s>(u ∩
map! <C-s>u) ∪
map! <C-s>in ∫
map! <C-s>di ∬
map! <C-s>io ∮
map! <C-s>tf ∴
map! <C-s>bc ∵
map! <C-s>ae ≅
map! <C-s>ne ≠
map! <C-s>>= ≥
map! <C-s><= ≤
map! <C-s><= ⇐
map! <C-s>=> ⇒
map! <C-s>== ⇔
map! <C-s>ns ∅
map! <C-s>pd ∂
map! <C-s>00 ∞
" French
map! <C-s>A> Â
map! <C-s>a> â
map! <C-s>A' Á
map! <C-s>a' á
map! <C-s>A` À
map! <C-s>a` À
map! <C-s>E> Ê
map! <C-s>e> ê
map! <C-s>E' É
map! <C-s>e' é
map! <C-s>E` È
map! <C-s>e` è
map! <C-s>O> Ô
map! <C-s>o> ô
map! <C-s>O' Ó
map! <C-s>o' ó
map! <C-s>O` Ò
map! <C-s>o` ò
map! <C-s>L' Ĺ
map! <C-s>l' ĺ
map! <C-s>C, Ç
map! <C-s>c, ç
map! <C-s>S, Ş
map! <C-s>s, ş
" Misc
map! <C-s>hh ←
map! <C-s>jj ↓
map! <C-s>kk ↑
map! <C-s>ll →
map! <C-s>hl ↔
" }}}
" }}}
" --------[ Commands ]-------------------------------------{{{
autocmd! bufwritepost init.vim source ~/.config/nvim/init.vim " auto reload vimrc when editing it
" Enable omni completion. (Ctrl-X Ctrl-O)
augroup omnifuncs
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd FileType css set omnifunc=csscomplete#CompleteCSS
    autocmd FileType c,cpp set omnifunc=ccomplete#Complete
    autocmd FileType java set omnifunc=javacomplete#Complete
    autocmd FileType java setlocal omnifunc=javacomplete#Complete
augroup end
" tern
if exists('g:plugs["tern_for_vim"]')
  let g:tern_show_argument_hints = 'on_hold'
  let g:tern_show_signature_in_pum = 1
  autocmd FileType javascript setlocal om6nifunc=tern#Complete
endif
" make CSS omnicompletion work for SASS and SCSS
autocmd BufNewFile,BufRead *.scss             set ft=scss.css
autocmd BufNewFile,BufRead *.sass             set ft=sass.css
autocmd FileType perl set autoindent|set smartindent|syntax on
" turn on list chars for dotfiles and notes
au FileType markdown,md,pandoc.markdown,txt,cvs set list lcs=tab:▸\ ,eol:¬,extends:❯,precedes:❮
au BufEnter init.vim,.tmux.conf,.zshrc,*cards.csv set list lcs=tab:▸\ ,eol:¬,extends:❯,precedes:❮
" folds
command! -nargs=+ Foldsearch exe "normal /".<q-args>."^M" | setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\|\|(getline(v:lnum+1)=~@/)?1:2 foldmethod=expr foldlevel=0 foldcolumn=2
" Notes & Pandoc
let g:semester = system('echo -n "$SEMESTER"')
command! -nargs=1 Note exe "e! " . fnameescape($NOTES_DIR . "/" . g:semester . "/<args>.txt")
command! -nargs=1 Ngrep lvimgrep "<args>" $NOTES_DIR/**/*.txt
autocmd FileType tex  let b:deoplete_disable_auto_complete = 1
autocmd FileType csv  let b:deoplete_disable_auto_complete = 1
autocmd BufEnter *.csv let b:deoplete_disable_auto_complete = 1
autocmd FileType txt  let b:deoplete_disable_auto_complete = 1
autocmd FileType tex  let b:deoplete_disable_auto_complete = 1
augroup markdown
   au!
   au BufNewFile,BufRead,BufWrite *.txt,*.md,*.mkd,*.markdown,*.mdwn setl ft=rmd
   au BufRead,BufNewFile,BufEnter   $NOTES_DIR/*/*.txt let &complete="$NOTES_DIR/**/*.txt"
   au BufRead,BufNewFile,BufEnter   $NOTES_DIR/*/*.txt lcd %:h
   "au BufRead,BufWrite,InsertChange $NOTES_DIR/*/*.txt syn match ErrorMsg '\%>79v.\+'
   au Filetype rmd map <C-p> :!echo<space>"require(rmarkdown);<space>render('<c-r>%')"<space>\|<space>R<space>--vanilla<enter>
augroup end

" augroup lLength
"   autocmd BufEnter * highlight OverLength ctermbg=11 ctermfg=9 guibg=11
"   autocmd BufEnter * match OverLength /\%79v.*/
" augroup END
" }}}
" }}}
" ========{ Vim Script Functions }======================================== " {{{
" --------[ Make the 81st column stand out ]--------------------------- {{{
"  " OR ELSE just the 81st column of wide lines...
highlight ColorColumn ctermbg=9 ctermfg=7
call matchadd('ColorColumn', '\%81v', 100)
" }}}
" --------[ Highlight matches when jumping to next ]------------------- {{{
" This rewires n and N to do the highlighing...
"nnoremap <silent> n   n:call HLNext(0.4)<cr>
"nnoremap <silent> N   N:call HLNext(0.4)<cr>
" OR ELSE just highlight the match in gold...
fun! HLNext (blinktime)
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let target_pat = '\c\%#\%('.@/.'\)'
    let ring = matchadd('WhiteOnRed', target_pat, 101)
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
    call matchdelete(ring)
    redraw
endfun
" }}}
" --------[ Always turn on syntax highlighting for diffs ]------------------ {{{
" EITHER select by the file-suffix directly...
augroup PatchDiffHighlight
    autocmd!
    autocmd BufEnter  *.patch,*.rej,*.diff   syntax enable
augroup END
" OR ELSE use the filetype mechanism to select automatically...
filetype on
augroup PatchDiffHighlight
    autocmd!
    autocmd FileType diff   syntax enable
augroup END
" }}}
" --------[ Open file with existing swp in readonly mode ]--------- {{{
augroup NoSimultaneousEdits
    autocmd!
    autocmd SwapExists * let v:swapchoice = 'o'
    autocmd SwapExists * echomsg
    autocmd SwapExists * echo 'Duplicate edit session (readonly)'
    autocmd SwapExists * echohl None
    autocmd SwapExists * sleep 2
augroup END
" }}}
" ------- [ generate header guard ]---------------------------------------- {{{
fun! IncludeGuard()
    let basename = substitute(bufname(""), '.*/', '', '')
    let guard = '_' . substitute(toupper(basename), '\.', '_', "H")
    call append(0, "#ifndef " . guard)
    call append(1, "#define " . guard)
    call append(line("$"), "#endif // for #ifndef " . guard)
endfun
" }}}
" --------[ IncHeader ]-------------------------------------------------- {{{
fun! IncHeader()
    let date = strftime("%B %d, %Y")
    call append(0, "" . "")
    call append(0, "/*" . "")
    call append(1, " * " . "Sullivan, Ryan")
    call append(2, " *" . "")
    call append(3, " * " . "CS A250")
    call append(4, " * " . date)
    call append(5, " *" . "")
    call append(6, " * " . "Lab ")
    call append(7, " */" . "")
endfun
" }}}
" ------- [ file Encoding ]-------------------------------------------- {{{
fun! ViewUTF8()
    set encoding=utf-8
    set termencoding=big5
endfun

fun! UTF8()
    set encoding=utf-8
    set termencoding=big5
    set fileencoding=utf-8
    set fileencodings=big5,utf-8
endfun

fun! Big5()
    set encoding=big5
    set fileencoding=big5
endfun
" }}}
" }}}
" }}}
