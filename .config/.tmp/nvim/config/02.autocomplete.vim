set winblend=0
set pumblend=5
" Set up completion
set completeopt=menuone,noinsert,noselect
set completeopt -=preview
set wildoptions=pum
set wildmode=longest:full,full
set wildmenu
set wildchar=<Tab>
" Ignore these
set wildignore=*.hg,*.git,*.svn                          " version control
set wildignore+=*.aux,*.out*.toc                         " latex intermediate files
set wildignore+=*.jpg,*.png,*.gif,,*.jpeg                " binary images
set wildignore+=*.o,*.obj,*.exe,*.class,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                                    " compiled spelling word list
set wildignore+=*.sw?                                    " vim swap files
set wildignore+=*.luac                                   " lua byte code
set wildignore+=migrations                               " django migrations
set wildignore+=*.pyc                                    " python byte code
set wildignore+=*.orig                                   " merge resolution files
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
