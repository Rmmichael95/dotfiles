" ========{ Plugins }================================================== " {{{1

if has('nvim')
    runtime! python_setup.vim
endif

" ----[ Dein ]------------------------------------ {{{2

if &compatible
    set nocompatible
endif

set runtimepath+=/home/ryanm/.vim/bundles/repos/github.com/Shougo/dein.vim

if dein#load_state('/home/ryanm/.vim/bundles')
    call dein#begin('/home/ryanm/.vim/bundles')

    call dein#add('/home/ryanm/.vim/bundles/repos/github.com/Shougo/dein.vim')
    call dein#add('Shougo/deoplete.nvim')
    if !has('nvim')
        call dein#add('roxma/nvim-yarp')
        call dein#add('roxma/vim-hug-neovim-rpc')
    endif
    call dein#add('Rmmichael95/nvim-docg-wrapper')
    call dein#add('Shougo/neoinclude.vim')
    call dein#add('Shougo/neco-syntax')
    call dein#add('Shougo/deol.nvim')
    call dein#add('Shougo/neosnippet')
    call dein#add('Shougo/neosnippet-snippets')
    call dein#add('Shougo/neco-vim')
    call dein#add('zchee/deoplete-zsh')
    call dein#add('othree/jspc.vim', {'on_ft': 'java'})
    call dein#add('autozimu/LanguageClient-neovim', {
                \ 'rev': 'next',
                \ 'build': 'bash install.sh',
                \ })
    call dein#add('w0rp/ale')
    call dein#add('ervandew/supertab')
    call dein#add('junegunn/fzf.vim')
    call dein#add('starcraftman/vim-eclim', {'on_ft': 'java'})
    call dein#add('tpope/vim-endwise')
    call dein#add('tpope/vim-commentary')
    call dein#add('tpope/vim-repeat', {'on_map': {'n': ['.']}})
    call dein#add('tpope/vim-dispatch')
    call dein#add('radenling/vim-dispatch-neovim')
    call dein#add('tpope/vim-fugitive', {
                \'on_cmd': ['Git', 'Gstatus', 'Gwrite', 'Glog', 'Gcommit', 'Gblame', 'Ggrep', 'Gdiff'],
                \ })
    call dein#add('tpope/vim-surround', {
                \ 'on_map': {'n' : ['cs', 'ds', 'ys'], 'x' : 'S'},
                \ 'depends': 'vim-repeat',
                \ })
    call dein#add('jiangmiao/auto-pairs')
    call dein#add('godlygeek/tabular', {
                \ 'on_cmd': [ 'Tab', 'Tabularize' ],
                \ 'augroup': 'tabular',
                \ })
    call dein#add('jeffkreeftmeijer/vim-numbertoggle')
    call dein#add('ntpeters/vim-better-whitespace')
    call dein#add('christoomey/vim-tmux-navigator')
    call dein#add('easymotion/vim-easymotion')
    call dein#add('powerman/vim-plugin-viewdoc')
    call dein#add('jgdavey/tslime.vim')
    call dein#add('benmills/vimux')
    call dein#add('qpkorr/vim-bufkill')
    call dein#add('mhinz/vim-startify')
    call dein#add('luochen1990/rainbow')
    call dein#add('terryma/vim-multiple-cursors', {'on_map': {'n': ['<C-n>', '<C-p>'], 'x': '<C-n>'}})
    call dein#add('chrisbra/NrrwRgn')
    call dein#add('tmhedberg/SimpylFold')
    call dein#add('Konfekt/FastFold')
    call dein#add('tpope/vim-sleuth')
    call dein#add('vim-scripts/L9')
    call dein#add('sheerun/vim-polyglot')
    call dein#add('dhruvasagar/vim-table-mode')
    call dein#add('jamessan/vim-gnupg')
    call dein#add('vim-airline/vim-airline')
    call dein#add('Shougo/vimproc.vim', {'build': 'make'})
    call dein#add('mbbill/undotree', {'on_cmd': 'UndotreeToggle'})
    call dein#add('zhaocai/GoldenView.Vim', {'on_cmd': '<Plug>ToggleGoldenViewAutoResize'})
    call dein#add('rhysd/vim-grammarous')
    " Python
    call dein#add('vim-scripts/indentpython.vim')
    call dein#add('nvie/vim-flake8')
    " Java
    call dein#add('Dinduks/vim-java-get-set', {'on_ft':'java'})
    call dein#add('tfnico/vim-gradle', {'on_ft': 'gradle'})
    call dein#add('vim-scripts/groovy.vim', {'on_ft': 'groovy'})
    " C++
    call dein#add('octol/vim-cpp-enhanced-highlight', {'on_ft': ['c', 'cpp', 'h']})
    call dein#add('derekwyatt/vim-fswitch', {'on_ft': ['c', 'cpp']})
    call dein#add('vim-scripts/DoxygenToolkit.vim', {'on_ft': ['c', 'cpp']})
    call dein#add('majutsushi/tagbar', {'on_cmd': 'TagbarToggle'})
    call dein#add('derekwyatt/vim-protodef', {'on_ft': ['c', 'cpp', 'h']})
    call dein#add('huawenyu/neogdb.vim', {'on_ft': ['c', 'cpp']})
    "call dein#add('dbgx/lldb.nvim', {'on_ft': ['c', 'cpp']})
    " ctags / cscope
    call dein#add('szw/vim-tags', {'on_cmd': 'GenerateTags'})
    call dein#add('vim-scripts/cscope.vim', {'on_ft': ['c', 'cpp']})
    call dein#add('JCLiang/vim-cscope-utils', {'on_ft': ['c', 'cpp']})
    " Markdown
    call dein#add('plasticboy/vim-markdown')
    call dein#add('vim-pandoc/vim-pantondoc', {'on_ft': ['markdown', 'pandoc.markdown', 'rmd']})
    call dein#add('vim-pandoc/vim-pandoc-syntax', {'on_ft': ['markdown', 'pandoc.markdown', 'rmd']})
    call dein#add('PProvost/vim-markdown-jekyll', {'on_ft': ['html', 'hbs', 'markdown', 'pandoc.markdown', 'rmd']})
    call dein#add('iamcco/mathjax-support-for-mkdp', {'on_ft': ['markdown', 'pandoc.markdown', 'rmd']})
    " Ruby
    call dein#add("tpope/vim-cucumber", {'on_ft': ['ruby', 'rb']})
    call dein#add("slim-template/vim-slim", {'on_ft': 'slim'})
    " Web
    call dein#add('othree/html5.vim', {'on_ft': ['html', 'html.handlebars']})
    call dein#add('cakebaker/scss-syntax.vim', {'on_ft': ['less', 'scss', 'sass']})
    call dein#add('elzr/vim-json', {'on_ft': 'json'})
    " erlang & elixir
    call dein#add('vim-erlang/vim-erlang-skeletons', {'on_ft': 'erl'})
    call dein#add('vim-erlang/vim-erlang-runtime', {'on_ft': 'erl'})
    call dein#add('vim-erlang/vim-erlang-tags', {'on_ft': 'erl'})
    call dein#add('elixir-editors/vim-elixir', {'on_ft': ['ex', 'exs', 'eex']})
    call dein#add('slashmili/alchemist.vim', {'on_ft': ['ex', 'esx', 'eex']})

    call dein#end()
    call dein#save_state()
endif

filetype plugin indent on
syntax enable
