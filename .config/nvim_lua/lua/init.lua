-- init.lua contains all of the initialization plugins for vim note;
-- This has to be sourced second since dein needs to run its scripts first.
-- This contains misc startup settings for vim
local g = vim.g     -- global variable
local o = vim.o     -- global options
local wo = vim.wo   -- window options
local bo = vim.bo   -- buffer options
local opt = vim.opt -- set options
local cmd = vim.cmd -- vim command

-- set system python3
g.python3_host_prog = '~/.local/share/nvim/.venv/bin/python'

cmd('syntax on')
cmd('filetype indent plugin on')

-- global options
o.showcmd       = true      -- show command info at bottom
o.showmatch     = true      -- brefiely highlight matching grouping symbols
o.laststatus    = 2         -- 2: show statusline in all windows
o.backspace     = 'indent,eol,start'       -- allow unrestricted backspacing in insert mode
o.ruler         = true      -- show current line/col number
o.scrolloff     = 10        -- number of lines from edge until screen scroll
o.mouse         = 'a'       -- enable all mouse modes
o.mousemodel    = 'popup'   -- right click pops up window
o.grepprg       = 'rg\\ --vimgrep'         -- use rg for vimgrep
o.hidden        = true      -- hide unloaded buffers instead of abandoning
o.splitbelow    = true      -- make hsplit below current window
o.splitright    = true      -- make vsplit to right of current window
o.inccommand    = 'nosplit' -- show affects of commands incrimentally
o.visualbell    = true      -- show visual bell instead of beeping
o.virtualedit   = o.virtualedit .. 'block' -- allow virual editing in visual block
-- window options
wo.spell        = false     -- don't check spelling
wo.wrap         = false     -- don't wrap text lines
wo.foldenable   = false     -- start with fold open
wo.foldmethod   = 'marker'  -- method to fold text; on mark
wo.number       = true      -- show line number on left
-- buffer options
bo.autoindent   = true      -- maintain indent of current line
bo.tabstop      = 4         -- number of spaces in a tab
bo.expandtab    = false     -- use spaces instead of tab characters
bo.softtabstop  = 4         -- make spaces feel like tabs backspacing
bo.synmaxcol    = 200       -- don't highlight long lines
-- set options
opt.shiftwidth  = 4         -- read help to set up later
opt.browsedir   = 'buffer'  -- put up directory requestor
opt.hlsearch    = false     -- don't highlight for searching
opt.ignorecase  = true      -- ignore case for pattern matching
opt.clipboard   = opt.clipboard .. 'unnamedplus' -- copy with system clipboard
opt.modeline    = false     -- the modeline is a well-known security risk

-- set colorscheme
o.termguicolors = true      -- enable 24bit colors in TUI, uses guibg/guifg
o.background    = 'dark'    -- set background dark/light
cmd('colorscheme everforest')      -- use everforest colorscheme; plays nice with redshift
cmd('highlight Normal guibg=NONE') -- keep transparent guibg
-- highlight 81st column darkred on lines that run long
cmd(autocmd BufEnter,FocusGained,BufWinEnter,WinEnter * match ColorColumn '\%81v.')

o.showbreak        = '↪'            -- str to put at begining of wrapped lines
wo.list            = true           -- show whitesoace chars
opt.listchars      = {
  nbsp             = '␣'',          -- CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
  extends          = '❯',           -- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
  precedes         = '❮',           -- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
  tab              = '▷',           -- WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7) + MIDLINE HORIZONTAL ELLIPSIS (U+22EF, UTF-8: E2 8B AF)
  eol              = '¬',           -- BULLET (U+2022, UTF-8: E2 80 A2)
}

opt.fillchars      = {
  diff             = '∙',           -- BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
  eob              = ' ',           -- NO-BREAK SPACE (U+00A0, UTF-8: C2 A0) to suppress ~ at EndOfBuffer
  fold             = '·',           -- MIDDLE DOT (U+00B7, UTF-8: C2 B7)
  vert             = '┃',           -- BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
}
-- file encoding
bo.fileencoding = 'utf-8'  -- file content encoding for current buffer
o.fileencodings = 'utf-8'  -- list of encoding considered when starting a file
o.fileformats   = {'unix', 'dos', 'mac'} -- gives eol formats
o.formatpgr     = 'par'    -- name of external program used to format lines

-- backups
o.backupskip    = '/tmp/*,/private/tmp/*",*.gpg' -- don't backup filename with these patterns
o.backupdir     = '$XDG_CONFIG_HOME/nvim/tmp/.backup//,/tmp' -- where to store backup files
o.undodir       = '$XDG_CONFIG_HOME/nvim/tmp/.undo//,/tmp' -- where to store undo files
o.directory     = '$XDG_CONFIG_HOME/nvim/tmp/.swp//,/tmp' -- where to store swap files
o.backup        = true  -- make backup before overwriting files
o.swapfile      = false -- its 2012, just do backups

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
