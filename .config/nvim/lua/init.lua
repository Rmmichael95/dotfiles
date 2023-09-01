-- init.lua contains all of the initialization plugins for vim note;
-- This has to be sourced second since dein needs to run its scripts first.
-- This contains misc startup settings for vim
local g = vim.g     -- global variable
local opt = vim.opt -- set options
local cmd = vim.cmd -- vim command

-- set system python3
g.python3_host_prog = '/usr/bin/python3'
--cmd([[let g:python3_host_prog '/home/ryanm/.local/share/nvim/.venv/bin/python3']])
-- set system ruby
g.ruby_host_prog = '/home/ryanm/.local/share/ruby/rbenv/versions/3.1.2/bin/neovim-ruby-host'
--cmd([[let g:ruby_host_prog = '/home/ryanm/.local/ruby/rbenv/versions/3.1.2/bin/neovim-ruby-host']])

cmd('syntax on')
cmd('filetype indent plugin on')

-- global options
opt.showcmd       = true      -- show command info at bottom
opt.showmatch     = true      -- brefiely highlight matching grouping symbols
opt.laststatus    = 2         -- 2: show statusline in all windows
opt.backspace     = 'indent,eol,start'       -- allow unrestricted backspacing in insert mode
opt.ruler         = true      -- show current line/col number
opt.scrolloff     = 10        -- number of lines from edge until screen scroll
opt.mouse         = 'a'       -- enable all mouse modes
opt.mousemodel    = 'popup'   -- right click pops up window
opt.grepprg       = 'rg\\ --vimgrep'         -- use rg for vimgrep
opt.hidden        = true      -- hide unloaded buffers instead of abandoning
opt.splitbelow    = true      -- make hsplit below current window
opt.splitright    = true      -- make vsplit to right of current window
opt.inccommand    = 'nosplit' -- show affects of commands incrimentally
opt.visualbell    = true      -- show visual bell instead of beeping
opt.virtualedit   = 'block'   -- allow virual editing in visual block
opt.laststatus    = 3         -- only one statusline
opt.winhl='LineNr:white'      -- make line number of inctive window white
-- window options
opt.spell        = false     -- don't check spelling
opt.wrap         = false     -- don't wrap text lines
opt.foldenable   = false     -- start with fold open
opt.foldmethod   = 'marker'  -- method to fold text; on mark
opt.number       = true      -- show line number on left
-- buffer options
opt.autoindent   = true      -- maintain indent of current line
opt.tabstop      = 4         -- number of spaces in a tab
opt.expandtab    = false     -- use spaces instead of tab characters
opt.softtabstop  = 4         -- make spaces feel like tabs backspacing
opt.synmaxcol    = 200       -- don't highlight long lines
-- set options
opt.shiftwidth  = 4         -- read help to set up later
g.browsedir     = 'buffer'  -- put up directory requestor
opt.hlsearch    = false     -- don't highlight for searching
opt.ignorecase  = true      -- ignore case for pattern matching
opt.clipboard   = 'unnamedplus' -- copy with system clipboard
opt.modeline    = false     -- the modeline is a well-known security risk

-- set colorscheme
opt.termguicolors = true      -- enable 24bit colors in TUI, uses guibg/guifg
opt.background    = 'dark'    -- set background dark/light
g.everforest_transparent_background = 1 -- keep transparent guibg
cmd('let g:everforest_background = "medium"') -- use everforest colorscheme; plays nice with redshift
cmd('let g:everforest_better_performance = 1') -- use everforest colorscheme; plays nice with redshift
cmd('colorscheme everforest') -- use everforest colorscheme; plays nice with redshift
-- highlight 81st column darkred on lines that run long
cmd([[autocmd BufEnter,FocusGained,BufWinEnter,WinEnter * match ColorColumn "\%81v."]])
cmd("highlight ColorColumn guibg=darkred")

opt.showbreak       = '↪'            -- str to put at begining of wrapped lines
opt.list            = true           -- show whitesoace chars
opt.listchars     = {
   nbsp = '␣',
   extends = '❯',
   precedes = '❮',
   tab = '▷⋯',
   eol = '¬'
}

opt.fillchars      = {
  diff             = '∙',           -- BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
  eob              = ' ',           -- NO-BREAK SPACE (U+00A0, UTF-8: C2 A0) to suppress ~ at EndOfBuffer
  fold             = '·',           -- MIDDLE DOT (U+00B7, UTF-8: C2 B7)
  vert             = '┃',           -- BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
}
-- file encoding
opt.fileencoding = 'utf-8'  -- file content encoding for current buffer
opt.fileencodings = 'utf-8'  -- list of encoding considered when starting a file
opt.fileformats   = {'unix', 'dos', 'mac'} -- gives eol formats
--opt.formatpgr     = 'par'    -- name of external program used to format lines

-- backups
opt.backupskip    = '/tmp/*,/private/tmp/*",*.gpg' -- don't backup filename with these patterns
opt.backupdir     = '/home/ryanm/.config/nvim/tmp/.backup/' -- where to store backup files
opt.undodir       = '/home/ryanm/.config/nvim/tmp/.undo/' -- where to store undo files
opt.directory     = '/home/ryanm/.config/nvim/tmp/.swp/' -- where to store swap files
opt.backup        = true  -- make backup before overwriting files
opt.swapfile      = false -- its 2014, just do backups

-- make dirs for backup
cmd([[
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif
]])
