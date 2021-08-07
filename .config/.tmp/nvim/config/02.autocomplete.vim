set winblend=0
set pumblend=5
" Set up completion
set omnifunc=syntaxcomplete#Complete
set complete=.,w,b,u,t
set completeopt=longest,menuone
set completeopt -=preview
set wildoptions=pum
set wildmode=list:longest,list:full
set wildmenu
set wildchar=<Tab>
" Ignore these
set wildignore=*.hg,*.git,*.svn                          " Version control
set wildignore+=*.aux,*.out*.toc                         " LaTex intermediate files
set wildignore+=*.jpg,*.png,*.gif,*.png,*.jpeg           " Binary images
set wildignore+=*.o,*.obj,*.exe,*.class,*.dll,*.manifest " Compiled object files
set wildignore+=*.spl                                    " Compiled spelling word list
set wildignore+=*.sw?                                    " Vim swap files
set wildignore+=*.luac                                   " Lua byte code
set wildignore+=migrations                               " Django migrations
set wildignore+=*.pyc                                    " Python byte code
set wildignore+=*.orig                                   " Merge resolution files
" Clojure/Leiningen
set wildignore+=classes
set wildignore+=lib
set timeoutlen=1000 ttimeoutlen=0
set noshowmode
set cmdheight=1
set shortmess+=c

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
