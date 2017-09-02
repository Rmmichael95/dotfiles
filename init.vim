" Maintainer: Ryan M Sullivan
" Last Change: December 06, 2016

" ------------------------------------------------------------------------------
" Vim Configuration
" ------------------------------------------------------------------------ " {{{

if has('vim_starting')
    if &compatible
        set nocompatible       " Be iMproved
    endif
endif

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
    set mouse=a
endif

" ========{ Plugins }===================================================== " {{{

" --------[ Dein ]------------------------------------ {{{

if &compatible
  set nocompatible
endif
set runtimepath+=/home/ryanm/.nvim/bundles/repos/github.com/Shougo/dien.vim

if dein#load_state('/home/ryanm/.nvim/bundles')
  call dein#begin(expand('/home/ryanm/.nvim/bundles'))
  call dein#add('/home/ryanm/.nvim/bundles/repos/github.com/Shougo/dien.vim')
  call dien#add('Shougo/dein.vim')
  call dein#add('Shougo/neocomplete.vim')
  call dein#add('Valloric/YouCompleteMe')
  call dein#add('scrooloose/syntastic')
  call dein#add('majutsushi/tagbar') " taskbar with indexed ctags
  call dein#add('jeffkreeftmeijer/vim-numbertoggle') " Toggle absolute and relative line numbers
  call dein#add('ntpeters/vim-better-whitespace') " Whitespace hightlighting
  call dein#add('christoomey/vim-tmux-navigator') " Unified tmix pane vim split navigation
  call dein#add('easymotion/vim-easymotion')
  call dein#add('wincent/command-t', {
  \ 'build_commands' : ['make', 'ruby'],
  \ 'build' : {
  \	'unix': 'cd ruby/command-t && {make clean; ruby extconf.rb && make }'
  \  }
  \})
  call dein#add('mileszs/ack.vim')
  call dein#add('mbbill/undotree', {'on': 'UndotreeToggle'})
  call dein#add('scrooloose/nerdtree', {'on':['NERDTreeToggle','NERDTreeFind']})
  call dein#add('Xuyuanp/nerdtree-git-plugin', {'on':['<Plug>NERDTreeToggle','<Plug>NERDTreeFind']})
  call dein#add('bling/vim-airline')
  call dein#add('Shougo/vimproc.vim', {
  \ 'build' : {
  \     'windows' : 'tools\\update-dll-mingw',
  \     'cygwin' : 'make -f make_cygwin.mak',
  \     'mac' : 'make',
  \     'linux' : 'make',
  \     'unix' : 'gmake',
  \    },
  \ })
  call dein#add('Shougo/vimshell.vim')
  call dein#add('Shougo/neomru.vim')
  call dein#add('Shougo/unite.vim')
  call dein#add('thoughtbot/vim-rspec')
  call dein#add('zhaocai/GoldenView.Vim', {'on':'<Plug>ToggleGoldenViewAutoResize'})
  call dein#add('SirVer/ultisnips')
  call dein#add('jgdavey/tslime.vim')
  call dein#add('bufkill.vim')
  call dein#add('mhinz/vim-startify')  " Cool startpage for vim
  call dein#add('oblitum/rainbow')
  call dein#add('editorconfig/editorconfig-vim')
  call dein#add('kristijanhusak/vim-multiple-cursors')
  call dein#add('chrisbra/NrrwRgn')
  call dein#add('tpope/vim-endwise')
  call dein#add('jiangmiao/auto-pairs')
  call dein#add('tpope/vim-surround')
  call dein#add('tpope/vim-commentary')
  call dein#add('tpope/vim-repeat')
  call dein#add('godlygeek/tabular')
  " general refactoring
  call dein#add('LucHermitte/lh-vim-lib')
  call dein#add('LucHermitte/lh-tags')
  call dein#add('LucHermitte/lh-dev')
  call dein#add('LucHermitte/lh-brackets')
  call dein#add('LucHermitte/vim-refactor')
  " Java
  call dein#add('Dinduks/vim-java-get-set') " Generate java getters and setters
  " Groovy
  call dein#add(  'vim-scripts/groovy.vim')
  " Gradle
  call dein#add(  'tfnico/vim-gradle')
  " C++
  call dein#add(  'octol/vim-cpp-enhanced-highlight', { 'for': ['cpp', 'c', 'h'] })
  call dein#add(  'derekwyatt/vim-protodef', { 'for': ['cpp', 'c', 'h'] })  " Parsing c++ .h files
  call dein#add(  'derekwyatt/vim-fswitch', { 'for': ['cpp', 'c'] })  " better switching between files
  call dein#add(   'vim-scripts/DoxygenToolkit.vim')
  " Ctag auto generate
  call dein#add(  'szw/vim-tags')
  call dein#add(  'vim-scripts/cscope.vim')
  call dein#add(  'tpope/vim-dispatch') " Used with vim-tags
  " Markdown
  call dein#add(  'vim-pandoc/vim-pandoc-syntax', { 'for': ['markdown', 'pandoc.markdown', 'md'] })
  call dein#add(  'vim-pandoc/vim-pantondoc', { 'for': ['markdown', 'pandoc.markdown', 'md'] })
  call dein#add(  'shime/vim-livedown', { 'for': ['markdown', 'pandoc.markdown', 'md'] })
  " Python
  call dein#add(  'klen/python-mode', { 'for': ['python'] })
  call dein#add(   'tmhedberg/SimpylFold')
  " Web
  call dein#add(  'othree/html5.vim', { 'for': ['html', 'html.handlebars'] })
  call dein#add(  'cakebaker/scss-syntax.vim', {'for': ['less', 'scss', 'sass']})
  call dein#add(  'elzr/vim-json'), {'for': 'json'}
  call dein#add(  'mustache/vim-mustache-handlebars', {'for': 'html.handlebars'})
  call dein#add(  'PProvost/vim-markdown-jekyll', {'for': ['html', 'hbs']})
  " Colors Themes
  call dein#add(  'daylerees/colour-schemes')
  call dein#add(  'flazz/vim-colorschemes')
  call dein#add(  'encody/vim-colors')
  call dein#add('dracula/vim')
  call dein#add('morhetz/gruvbox')
  call dein#add('effkay/argonaut.vim')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('tpope/vim-fugitive') " for help with c tags and git/buffer handling ...

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable


" }}}

" --------[ Plugin Settings ]----------------------------------------------- {{{
if has('nvim')
    runtime! python_setup.vim
endif

" auto install new plugins
if dien#check_install()
    call dien#install()
endif


" --------[ Ctags ]---------------------------- {{{
let g:vim_tags_auto_generate = 0
let g:vim_tags_use_language_field = 1
let g:vim_tags_main_file = 'tags'

" lh-tags


" Tagbar
nmap <F8> :TagbarToggle<CR>
au BufWritePost *.c,*.cpp,*.h silent! !ctags -R &

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

"  }}}

" }}}

nnoremap <F9> :Dispatch<CR>

" --------[ YMC Options ]---------------------- {{{

"cm_register_as_syntastic_checker = 1

"YCM will put icons in Vim's gutter on lines that have a diagnostic set.
""Turning this off will also turn off the YcmErrorLine and YcmWarningLine
"highlighting
let g:ycm_enable_diagnostic_signs = 1
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_always_populate_location_list = 1 "default 0
let g:ycm_open_loclist_on_ycm_diags = 1 "default 1

let g:ycm_complete_in_strings = 1 "default 1
let g:ycm_collect_identifiers_from_tags_files = 1 "default 0
let g:ycm_path_to_python_interpreter = '' "default ''

let g:ycm_server_use_vim_stdout = 0 "default 0 (logging to console)
let g:ycm_server_log_level = 'info' "default info

let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 1

let g:ycm_goto_buffer_command = 'same-buffer' "[ 'same-buffer', 'horizontal-split', 'vertical-split', 'new-tab' ]
let g:ycm_filetype_whitelist = { '*': 1 }
let g:ycm_key_invoke_completion = '<C-Space>'

" }}}

" --------[ Syntastic Options ]---------------- {{{

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:Syntastic_quiet_messages = { "type": "style" }

let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++ -Wall -Wextra -Wpedantic'

let b:syntastic_cpp_cflags = 'I/usr/include/libsoup-2.4'
let b:Syntastic_cpp_compiler_options = ' -std=c++0x'
let syntastic_cpp_checkers=[ 'gcc', 'make' ]
let Syntastic_cpp_include_dirs = [ 'Syntastic_cpp_remove_include_errorsdes', 'headers' ]
"let g:syntastic_c_compiler_options = 'ansi -DMACRO_NAME'
"let g:Syntastic_cpp_remove_include_errors = 1
let g:syntastic_cpp_check_header = 1

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
autocmd BufRead,BufNewFile *.md,*.markdown setlocal filetype=pandoc.markdown \" Automatically set filetype for Markdown files"

" Python
autocmd BufWinEnter *.py setlocal foldexpr=SimpylFold(v:lnum) foldmethod=expr
autocmd BufWinLeave *.py setlocal foldexpr< foldmethod<
" for debugging pyclewn
let pyclewn_args="--terminal='tmux,split-window'" " open tmux split to interact with debugee

" }}}

" --------[ General Plugin Settings ]---------- {{{

" --------[ Navigation ]----------------------- {{{
" Undotree setup
let g:undotree_WindowLayout='botright'
let g:undotree_SetFocusWhenToggle=1
nnoremap <silent> <F5> :UndotreeToggle<CR>

" NERDTree setup
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

" Unite setup
"let g:unite_data_directory=g:vimDir.'/.cache/unite'
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable=1
let g:unite_source_rec_max_cache_files=5000
let g:unite_prompt='» '

if executable('ack')
    let g:unite_source_grep_command='ack'
    let g:unite_source_grep_default_opts='--no-heading --no-color -a -C4'
    let g:unite_source_grep_recursive_opt=''
endif

function! s:unite_settings()
    imap <buffer> <C-j>   <Plug>(unite_select_next_line)
    imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
    nmap <buffer> Q <plug>(unite_exit)
    nmap <buffer> <esc> <plug>(unite_exit)
    imap <buffer> <esc> <plug>(unite_exit)
endfunction

autocmd FileType unite call s:unite_settings()

" Set Unite leader
nmap <space> [unite]
nnoremap [unite] <nop>

" Set useful Unite mappings
nnoremap <silent> [unite]t :<C-u>Unite -auto-resize -buffer-name=files file<cr>
nnoremap <silent> [unite]y :<C-u>Unite -auto-resize -buffer-name=yanks history/yank<cr>
nnoremap <silent> [unite]l :<C-u>Unite -auto-resize -buffer-name=line line<cr>
nnoremap <silent> [unite]b :<C-u>Unite -auto-resize -buffer-name=buffers buffer<cr>
nnoremap <silent> [unite]m :<C-u>Unite -auto-resize -buffer-name=mappings mapping<cr>

" GoldenView setup
let g:goldenview__enable_default_mapping=0
nmap <F4> <Plug>ToggleGoldenViewAutoResize

" UltiSnips setup
let g:UltiSnipsExpandTrigger='<c-e>'
let g:UltiSnipsJumpForwardTrigger='<c-j>'
let g:UltiSnipsJumpBackwardTrigger='<c-k>'
"let g:UltiSnipsSnippetsDir=plugDir.'/vim-snippets/UltiSnips'

" }}}

" RSpec.vim mappings
map <Leader>rs :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

let g:rspec_command = "Dispatch rspec {spec}"

" -----------[ Startify Configuration ]---------------------- {{{
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

" -------- [ Rainbow setup ]-------------------------------- {{{
let g:rainbow_active = 1

let g:rainbow_load_separately = [
            \ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
            \ [ '*.tex' , [['(', ')'], ['\[', '\]']] ],
            \ [ '*.cpp' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
            \ [ '*.{html,htm}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
            \ ]

au FileType c,cpp,h,objc,objcpp,python,java,javascript call rainbow#load()
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

" Tabularize setup {{{
nmap <Leader>a& :Tabularize /&<CR>
vmap <Leader>a& :Tabularize /&<CR>
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:<CR>
vmap <Leader>a: :Tabularize /:<CR>
nmap <Leader>a:: :Tabularize /:\zs<CR>
vmap <Leader>a:: :Tabularize /:\zs<CR>
nmap <Leader>a, :Tabularize /,<CR>
vmap <Leader>a, :Tabularize /,<CR>
nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
" }}}

" Pandoc setup {{{
let g:pandoc_use_conceal = 1
let g:pandoc_syntax_dont_use_conceal_for_rules = ['block', 'codeblock_start', 'codeblock_delim']
let g:pandoc_syntax_user_cchars = {'li': '*'}
let g:pantondoc_use_pandoc_markdown = 1
"let g:pandoc#formatting#equalprg = \"pandoc -t markdown --no-wrap --atx-headers"
" }}}
" Livedown setup {{{
let g:livedown_autorun = 0
let g:livedown_open = 1
let g:livedown_port = 1337
map <leader>gm :call LivedownPreview()<CR>
" }}}
" eclim, Run Checkstyle on open/write {{{
autocmd BufWinEnter *.java :Checkstyle
autocmd BufWritePost *.java :Checkstyle
let g:EclimCompletionMethod = 'omnifunc'
" }}}

" Gruvbox setup {{{
let g:gruvbox_bold = 0
if !has("gui_running")
    let g:gruvbox_italic = 0
endif
" }}}

" Gitgutter setup
let g:gitgutter_realtime=0

" Fugitive setup {{{
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

"  }}}

" }}}

" }}}

" ========{ Formatting }================================================== " {{{

if has("vms")
    set nobackup		" do not keep a backup file, use versions instead
else
    set backup		" keep a backup file
endif

set history=10000	" remember everything
set t_Co=256        "256 color vim
set number " Always turn on line numbers
highlight LineNr ctermfg=grey " line number coloring

set ruler		    " show the cursor position all the time
set showcmd		    " display incomplete commands
set incsearch		" do incremental searching
set autoread        " auto read when file changes from outside

set expandtab
set smarttab
set shiftwidth=4    " configure tabs
set softtabstop=4   " configure tabs
set tabstop=4       " configure tabs

set autoindent      " set autoindent
set hidden
set ignorecase
set smartcase
set showmatch
set incsearch
set hlsearch
set ls=2
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set bs=2

filetype off          " necessary to make ftdetect work on Linux
syntax on
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

set cursorline
set nowrap
set completeopt -=preview
set wildchar=<TAB>  " start wild expansion in the command line using <TAB>"
set wildmenu
" ignore these files while expanding wild chars
set wildignore=*.o,*.class,*.pyc

set ttyfast
set noshowmode
set cmdheight=1

set encoding=utf-8    " Set right encoding and formats
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,big5,gb2312,latin1
"set fileformat=unix  " unix file format
"set nrformats-=octal " octal num format


" ------[ Base16-Vim ]--------
if filereadable(expand("~/.vimrc_background"))
    let base16colorspace=256
    source ~/.vimrc_background
endif

" ------[ code folding ]------
command! -nargs=+ Foldsearch exe "normal /".<q-args>."^M" | setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\|\|(getline(v:lnum+1)=~@/)?1:2 foldmethod=expr foldlevel=0 foldcolumn=2
set fdm=marker " for folds

" ------[ Reload buffers ]----
" autocmd InsertEnter * :bufdo e " on insert mode"

" }}}

" ========{ Basic UI Configuration }====================================== " {{{

map Q gq " Don't use Ex mode, use Q for formatting
let leader = "," " remap leader to z (from \)
let g:leader = "," " remap leader to z (global)
let  mapleader = "," " remap leader to , (from \)
let g:mapleader = "," " remap leader to z (global)
set timeoutlen=2000
set pastetoggle=<F3>
map <leader>r :source ~/.config/nvim/init.vim<cr>
" auto reload vimrc when editing it
autocmd! bufwritepost init.vim source ~/.config/nvim/init.vi:

" ---------------[ Navigate Vim Splits ]-----------------------------------------

nnoremap <C-J> <C-W><C-J> "Ctrl-j to move down a split
nnoremap <C-K> <C-W><C-K> "Ctrl-k to move up a split
nnoremap <C-L> <C-W><C-L> "Ctrl-l to move    right a split
nnoremap <C-H> <C-W><C-H> "Ctrl-h to move left a split

"Open new split panes to right and bottom, which feels more natural than Vim’s default:

set splitbelow
set splitright

"Max out the height of the current split
"ctrl + w _

"Max out the width of the current split
"ctrl + w |

"Normalize all split sizes, which is very handy when resizing terminal
"ctrl + w =

"Swap top/bottom or left/right split
"Ctrl+W R

"Break out current window into a new tabview
"Ctrl+W T

"Close every window in the current tabview but the current one
"Ctrl+W o

" new tab
map <C-t><C-t> :tabnew<CR>
" close tab
map <C-t><C-w> :tabclose<CR>

" Bash like keys for the command line
cnoremap <C-A>      <Home>
cnoremap <C-E>      <End>
cnoremap <C-K> <C-U>

" allow multiple indentation/deindentation in visual mode
vnoremap < <gv
vnoremap > >gv

" :cd. change working directory to that of the current file
cmap cd. lcd %:p:h

" map leader p to start Pyclewn, leader o to set up the debugging enviernment
map <leader>p :Pyclewn gdb <cr>
map <leader>o :Cinferiortty \| :Cmapkeys \| :Cfile main <cr>

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
    " Enable file type detection.
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on
endif

" --------[ Language specific ]--------
set spelllang=en_us   " Turn on spell check: English

" C++
" ,g generates the header guard
map <leader>g :call IncludeGuard()<CR> " func in other section

" Other
" Enable omni completion. (Ctrl-X Ctrl-O)
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType java set omnifunc=javacomplete#Complete

" use syntax complete if nothing else available
if has("autocmd") && exists("+omnifunc")
  autocmd Filetype *
              \	if &omnifunc == "" |
              \		setlocal omnifunc=syntaxcomplete#Complete |
              \	endif
endif

set cot-=preview "disable doc preview in omnicomplete

" make CSS omnicompletion work for SASS and SCSS
autocmd BufNewFile,BufRead *.scss             set ft=scss.css
autocmd BufNewFile,BufRead *.sass             set ft=sass.css

" }}}

" ========{ Vim Script Functions }======================================== " {{{


" ------[ Make the 81st column stand out ]---------------------
"  " OR ELSE just the 81st column of wide lines...
highlight ColorColumn ctermbg=LightYellow
call matchadd('ColorColumn', '\%81v', 100)

" --------[ Highlight matches when jumping to next ]-------------------

" This rewires n and N to do the highlighing...
"nnoremap <silent> n   n:call HLNext(0.4)<cr>
"nnoremap <silent> N   N:call HLNext(0.4)<cr>

" OR ELSE just highlight the match in gold...
function! HLNext (blinktime)
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let target_pat = '\c\%#\%('.@/.'\)'
    let ring = matchadd('WhiteOnRed', target_pat, 101)
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
    call matchdelete(ring)
    redraw
endfunction


" --------[ Always turn on syntax highlighting for diffs ]------------------
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
" ------[ Open any file with a pre-existing swapfile in readonly mode ]---------

augroup NoSimultaneousEdits
    autocmd!
    autocmd SwapExists * let v:swapchoice = 'o'
    autocmd SwapExists * echomsg
    autocmd SwapExists * echo 'Duplicate edit session (readonly)'
    autocmd SwapExists * echohl None
    autocmd SwapExists * sleep 2
augroup END

" function to generate c++ header guard, map in other section
fun! IncludeGuard()
   let basename = substitute(bufname(""), '.*/', '', '')
   let guard = '_' . substitute(toupper(basename), '\.', '_', "H")
   call append(0, "#ifndef " . guard)
   call append(1, "#define " . guard)
   call append( line("$"), "#endif // for #ifndef " . guard)
endfun

" UTF-8
fun! ViewUTF8()
	set encoding=utf-8
	set termencoding=big5
endfun

fun! UTF8()
	set encoding=utf-8
	set termencoding=big5
	set fileencoding=utf-8
	set fileencodings=ucs-bom,big5,utf-8,latin1
endfun

fun! Big5()
	set encoding=big5
	set fileencoding=big5
endfun

" }}}

" }}}
