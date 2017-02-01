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
map <leader>r :source ~/.vimrc <cr>
" auto reload vimrc when editing it
autocmd! bufwritepost .vimrc source ~/.vimrc

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

" ========{ Plugins }===================================================== " {{{

" --------[ Plugin Settings ]----------------------------------------------- {{{
if has('nvim')
    runtime! python_setup.vim
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
" --------[ PDF ]------------------------------
"  " Opens PDF in vim as text with wrapping
command! -complete=file -nargs=1 Rpdf :r !pdftotext -nopgbrk <q-args> - |fmt -csw78
let g:pdf_convert_on_read = 1  " Open PDF to read only

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

" --------[ NeoBundle ]------------------------------------ {{{

" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if &compatible
    set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'
" NeoBundleFetch 'Shougo/vundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

" Vimscript testing
NeoBundleFetch 'thinca/vim-themis'
NeoBundleFetch 'Valloric/YouCompleteMe'
NeoBundleFetch 'scrooloose/syntastic'
NeoBundleFetch 'majutsushi/tagbar' " taskbar with indexed ctags
NeoBundleFetch 'jeffkreeftmeijer/vim-numbertoggle' " Toggle absolute and relative line numbers
NeoBundleFetch 'ntpeters/vim-better-whitespace' " Whitespace hightlighting
NeoBundleFetch 'christoomey/vim-tmux-navigator' " Unified tmix pane vim split navigation
NeoBundleFetch 'easymotion/vim-easymotion'
NeoBundleFetch 'wincent/command-t'
"NeoBundleFetch 'kien/ctrlp.vim'  " Fuzzy search in vimscript
NeoBundleFetch 'mileszs/ack.vim'
NeoBundleFetch 'mbbill/undotree', {'on': 'UndotreeToggle'}
NeoBundleFetch 'scrooloose/nerdtree', {'on':['NERDTreeToggle','NERDTreeFind']}
NeoBundleFetch 'Xuyuanp/nerdtree-git-plugin' , {'on':['<Plug>NERDTreeToggle','<Plug>NERDTreeFind']}
NeoBundleFetch 'scrooloose/nerdcommenter'
NeoBundleFetch 'bling/vim-airline'
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }
NeoBundleFetch 'Shougo/vimshell.vim'
NeoBundleFetch 'Shougo/neomru.vim'
NeoBundleFetch 'Shougo/unite.vim'
NeoBundleFetch 'rhysd/open-pdf.vim'
NeoBundleFetch 'Shougo/unite.vim'
NeoBundleFetch 'thoughtbot/vim-rspec'
NeoBundleFetch 'kana/vim-flavor'
NeoBundleFetch 'zhaocai/GoldenView.Vim', {'on':'<Plug>ToggleGoldenViewAutoResize'}
NeoBundleFetch 'SirVer/ultisnips'
NeoBundleFetch 'ladislas/vim-snippets'
NeoBundleFetch 'jgdavey/tslime.vim'
NeoBundleFetch 'bufkill.vim'
NeoBundleFetch 'mhinz/vim-startify'  " Cool startpage for vim
NeoBundleFetch 'oblitum/rainbow'
NeoBundleFetch 'editorconfig/editorconfig-vim'
NeoBundleFetch 'kristijanhusak/vim-multiple-cursors'
NeoBundleFetch 'tomtom/tcomment_vim'
NeoBundleFetch 'chrisbra/NrrwRgn'
NeoBundleFetch 'tpope/vim-endwise'
NeoBundleFetch 'jiangmiao/auto-pairs'
NeoBundleFetch 'tpope/vim-surround'
NeoBundleFetch 'tpope/vim-commentary'
NeoBundleFetch 'tpope/vim-repeat'
NeoBundleFetch 'godlygeek/tabular'
" general refactoring
NeoBundleFetch 'LucHermitte/lh-vim-lib'
NeoBundleFetch 'LucHermitte/lh-tags'
NeoBundleFetch 'LucHermitte/lh-dev'
NeoBundleFetch 'LucHermitte/lh-brackets'
NeoBundleFetch 'LucHermitte/vim-refactor'
" help compile and test
NeoBundleFetch 'LucHermitte/vim-build-tools-wrapper'
" AWK, Bash, C/C++, LaTeX, Perl, VIm-Script IDE plugins
NeoBundleFetch 'WolfgangMehner/vim-plugins'
" Java
NeoBundleFetch 'Dinduks/vim-java-get-set' " Generate java getters and setters
" Groovy
NeoBundleFetch 'vim-scripts/groovy.vim'
" Gradle
NeoBundleFetch 'tfnico/vim-gradle'
" C++
NeoBundleFetch 'octol/vim-cpp-enhanced-highlight', { 'for': ['cpp', 'c', 'h'] }
NeoBundleFetch 'derekwyatt/vim-protodef', { 'for': ['cpp', 'c', 'h'] }  " Parsing c++ .h files
NeoBundleFetch 'derekwyatt/vim-fswitch', { 'for': ['cpp', 'c'] }  " better switching between files
"NeoBundleFetch 'vim-scripts/DoxygenToolkit.vim'
" Ctag auto generate
NeoBundleFetch 'szw/vim-tags'
NeoBundleFetch 'vim-scripts/cscope.vim'
NeoBundleFetch 'tpope/vim-dispatch' " Used with vim-tags
" Markdown
NeoBundleFetch 'vim-pandoc/vim-pandoc-syntax', { 'for': ['markdown', 'pandoc.markdown', 'md'] }
NeoBundleFetch 'vim-pandoc/vim-pantondoc', { 'for': ['markdown', 'pandoc.markdown', 'md'] }
NeoBundleFetch 'shime/vim-livedown', { 'for': ['markdown', 'pandoc.markdown', 'md'] }
" Python
NeoBundleFetch 'klen/python-mode', { 'for': ['python'] }
NeoBundleFetch 'tmhedberg/SimpylFold'
" Web
NeoBundleFetch 'othree/html5.vim', { 'for': ['html', 'html.handlebars'] }
NeoBundleFetch 'cakebaker/scss-syntax.vim', {'for': ['less', 'scss', 'sass']}
NeoBundleFetch 'elzr/vim-json', {'for': 'json'}
NeoBundleFetch 'mustache/vim-mustache-handlebars', {'for': 'html.handlebars'}
NeoBundleFetch 'skammer/vim-css-color', {'for': ['less', 'scss', 'sass']}
NeoBundleFetch 'PProvost/vim-markdown-jekyll', {'for': ['html', 'hbs']}
" Colors Themes
NeoBundleFetch 'daylerees/colour-schemes'
NeoBundleFetch 'flazz/vim-colorschemes'
NeoBundleFetch 'encody/vim-colors'
NeoBundleFetch 'dracula/vim'
NeoBundleFetch 'morhetz/gruvbox'
NeoBundleFetch 'effkay/argonaut.vim'
NeoBundleFetch 'airblade/vim-gitgutter'
NeoBundleFetch 'tpope/vim-fugitive' " for help with c tags and git/buffer handling

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" }}}

" --------[ Vundle Plugins ]------------------------------------- {{{

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Required:<SNR>
filetype plugin indent on

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'thinca/vim-themis'

Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-fugitive'
Plugin 'jeffkreeftmeijer/vim-numbertoggle' " Toggle absolute and relative line numbers
Plugin 'ntpeters/vim-better-whitespace' " Whitespace hightlighting
Plugin 'christoomey/vim-tmux-navigator' " Unified tmix pane vim split navigation
Plugin 'easymotion/vim-easymotion'
Plugin 'wincent/command-t'
"Plugin 'kien/ctrlp.vim'  " filetree with buffers
Plugin 'mileszs/ack.vim'
Plugin 'mbbill/undotree', {'on': 'UndotreeToggle'}
Plugin 'scrooloose/nerdtree', {'on':['NERDTreeToggle','NERDTreeFind']}
Plugin 'Xuyuanp/nerdtree-git-plugin' , {'on':['<Plug>NERDTreeToggle','<Plug>NERDTreeFind']}
Plugin 'scrooloose/nerdcommenter'
Plugin 'bling/vim-airline'
"Plugin 'edkolev/tmuxline.vim'
Plugin 'oblitum/rainbow'
Plugin 'rhysd/open-pdf.vim'
Plugin 'Shougo/vimshell.vim'
Plugin 'Shougo/neomru.vim'
Plugin 'Shougo/unite.vim'
Plugin 'thoughtbot/vim-rspec'
Plugin 'zhaocai/Goldenview.vim', {'on':'<Plug>ToggleGoldenViewAutoResize'}
Plugin 'SirVer/ultisnips'
Plugin 'ladislas/vim-snippets'
Plugin 'jgdavey/tslime.vim'
Plugin 'mhinz/vim-startify'  " Cool startpage for vim
Plugin 'editorconfig/editorconfig-vim'
Plugin 'kristijanhusak/vim-multiple-cursors'
Plugin 'tomtom/tcomment_vim'
Plugin 'chrisbra/NrrwRgn'
Plugin 'tpope/vim-endwise'
Plugin 'jiangmiao/auto-pairs'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-repeat'
Plugin 'godlygeek/tabular'
Plugin 'octol/vim-cpp-enhanced-highlight', { 'for': ['cpp', 'c', 'h'] }
Plugin 'derekwyatt/vim-protodef', { 'for': ['cpp', 'c', 'h'] }  " Parsing c++ .h files
Plugin 'derekwyatt/vim-fswitch', { 'for': ['cpp', 'c'] }  " better switching between files
Plugin 'vim-pandoc/vim-pandoc-syntax', { 'for': ['markdown', 'pandoc.markdown', 'md'] }
Plugin 'vim-pandoc/vim-pantondoc', { 'for': ['markdown', 'pandoc.markdown', 'md'] }
Plugin 'shime/vim-livedown', { 'for': ['markdown', 'pandoc.markdown', 'md'] }
Plugin 'klen/python-mode', { 'for': ['python'] }
Plugin 'othree/html5.vim', { 'for': ['html', 'html.handlebars'] }
Plugin 'cakebaker/scss-syntax.vim', {'for': ['less', 'scss', 'sass']}
Plugin 'elzr/vim-json', {'for': 'json'}
Plugin 'mustache/vim-mustache-handlebars', {'for': 'html.handlebars'}
Plugin 'skammer/vim-css-color', {'for': ['less', 'scss', 'sass']}
Plugin 'PProvost/vim-markdown-jekyll', {'for': ['html', 'hbs']}
Plugin 'daylerees/colour-schemes'
Plugin 'flazz/vim-colorschemes'
Plugin 'encody/vim-colors'
Plugin 'dracula/vim'
Plugin 'morhetz/gruvbox'
Plugin 'effkay/argonaut.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'WolfgangMehner/vim-plugins'
Plugin 'tpope/vim-dispatch' " Used with vim-tags
Plugin 'LucHermitte/lh-vim-lib'
Plugin 'LucHermitte/lh-tags'
Plugin 'LucHermitte/lh-dev'
Plugin 'LucHermitte/lh-brackets'
Plugin 'LucHermitte/vim-refactor'
Plugin 'szw/vim-tags'
"Plugin 'vim-scripts/DoxygenToolkit.vim'

Plugin 'vim-scripts/cscope.vim'
Plugin 'LucHermitte/vim-build-tools-wrapper'
Plugin 'vim-scripts/groovy.vim'
Plugin 'tfnico/vim-gradle'



" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"  }}}

" }}}

" }}}
