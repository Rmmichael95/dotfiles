-- init.lua contains all of the initialization plugins for vim note;
-- This has to be sourced second since dein needs to run its scripts first.
-- This contains misc startup settings for vim
local g = vim.g -- global variable
local o = vim.opt -- set options
local cmd = vim.cmd -- vim command

-- lua filetype detection
g.do_filetype_lua = 1

-- set system python3
g.python3_host_prog = "/usr/bin/python3"

-- Fix markdown indentation settings
g.markdown_recommended_style = 0

g.netrw_banner = 0
g.netrw_liststyle = 3
g.netrw_browse_split = 4
g.netrw_altv = 1
g.netrw_winsize = 25
g.loaded_netrwPlugin = 1

g.autoformat = true
g.deprecation_warnings = false -- Hide deprecation warnings

-- Set filetype to `bigfile` for files larger than 1.5 MB
-- Only vim syntax will be enabled (with the correct filetype)
-- LSP, treesitter and other ft plugins will be disabled.
-- mini.animate will also be disabled.
g.bigfile_size = 1024 * 1024 * 1.5 -- 1.5 MB

-- Show the current document symbols location from Trouble in lualine
-- You can disable this for a buffer by setting `vim.b.trouble_lualine = false`
g.trouble_lualine = true

--cmd("syntax on")
--cmd("filetype indent plugin on")

-- global options
o.autowrite = true -- Enable auto write
o.completeopt = "menu,menuone,noselect"
o.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions
o.confirm = true -- Confirm to save changes before exiting modified buffer
o.expandtab = true -- use spaces instead of tab characters
o.showcmd = true -- show command info at bottom
o.showmatch = true -- brefiely highlight matching grouping symbols
o.backspace = "indent,eol,start" -- allow unrestricted backspacing in insert mode
o.ruler = true -- show current line/col number
o.scrolloff = 10 -- number of lines from edge until screen scroll
o.mouse = "a" -- enable all mouse modes
o.mousemodel = "popup" -- right click pops up window
o.grepprg = "rg\\ --vimgrep" -- use rg for vimgrep
o.hidden = true -- hide unloaded buffers instead of abandoning
o.splitright = true -- make vsplit to right of current window
o.splitbelow = true -- make hsplit below current window
o.splitkeep = "screen"
o.inccommand = "nosplit" -- show affects of commands incrimentally
o.visualbell = true -- show visual bell instead of beeping
o.virtualedit = "block" -- allow virual editing in visual block
o.laststatus = 3 -- only one statusline
o.winhl = "LineNr:white" -- make line number of inctive window white
-- window options
o.spell = false -- don't check spelling
o.wrap = false -- don't wrap text lines
o.foldenable = false -- start with fold open
o.foldmethod = "marker" -- method to fold text; on mark
o.number = true -- show line number on left
-- buffer options
o.autoindent = true -- maintain indent of current line
o.tabstop = 4 -- number of spaces in a tab
o.softtabstop = 4 -- make spaces feel like tabs backspacing
o.synmaxcol = 200 -- don't highlight long lines
-- set options
o.shiftwidth = 4 -- read help to set up later
o.winminwidth = 5 -- Minimum window width
g.browsedir = "buffer" -- put up directory requester
o.hlsearch = false -- don't highlight for searching
o.ignorecase = true -- ignore case for pattern matching
o.smartcase = true -- smart search case-sensativity
o.modeline = false -- the modeline is a well-known security risk
o.signcolumn = "yes"

o.inccommand = "nosplit" -- preview incremental substitute
o.jumpoptions = "view"
o.winblend = 0
o.pumblend = 0 -- Popup blend
o.pumheight = 10 -- Maximum number of entries in a popup

o.showmode = false -- Dont show mode since we have a statusline
o.scrolloff = 4 -- Lines of context
o.sidescrolloff = 8 -- Columns of context
--o.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }

-- only set clipboard if not in ssh, to make sure the OSC 52
-- integration works automatically. Requires Neovim >= 0.10.0
o.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard
o.iskeyword:append("-") -- hiphenated oneword
o.spelllang = { "en" }
o.spelloptions:append("noplainbuffer")

-- set colorscheme
o.termguicolors = true -- enable 24bit colors in TUI, uses guibg/guifg
o.background = "dark" -- set background dark/light

-- highlight 81st column darkred on lines that run long
cmd([[autocmd BufEnter,FocusGained,BufWinEnter,WinEnter * match ColorColumn "\%81v."]])
cmd("highlight ColorColumn guibg=darkred")

o.showbreak = "↪" -- str to put at beginning of wrapped lines
o.list = true -- show whitesoace chars
o.listchars = {
	nbsp = "␣",
	extends = "❯",
	precedes = "❮",
	tab = "▷⋯",
	eol = "¬",
}

o.fillchars = {
	foldopen = "",
	foldclose = "",
	foldsep = " ",
	fold = "·", -- MIDDLE DOT (U+00B7, UTF-8: C2 B7)
	diff = "/", -- BULLET OPERATOR (U+2219, UTF-8: E2 88 99)
	vert = "┃", -- BOX DRAWINGS HEAVY VERTICAL (U+2503, UTF-8: E2 94 83)
	eob = " ",
}
-- file encoding
o.fileencoding = "utf-8" -- file content encoding for current buffer
o.fileencodings = "utf-8" -- list of encoding considered when starting a file
o.fileformats = { "unix", "dos", "mac" } -- gives eol formats
--o.formatpgr     = "par"    -- name of external program used to format lines
o.foldlevel = 99
--o.formatexpr = "v:lua.require'lazyvim.util'.format.formatexpr()"
o.formatoptions = "jcroqlnt" -- tcqj
o.grepformat = "%f:%l:%c:%m"

-- backups
o.backupskip = "/tmp/*,/private/tmp/*,*.gpg" -- don't backup filename with these patterns
o.backupdir = "/home/ryanm/.local/state/nvim/backup/" -- where to store backup files
o.undodir = "/home/ryanm/.local/state/nvim/undo/" -- where to store undo files
o.directory = "/home/ryanm/.local/state/nvim/swap/" -- where to store swap files
o.backup = true -- make backup before overwriting files
o.swapfile = false -- its 2014, just do backups
o.undofile = true -- undo across edits
o.undolevels = 10000 -- undo everything

o.shortmess = o.shortmess + "A" -- ignore annoying swapfile messages
o.shortmess = o.shortmess + "I" -- no splash screen
o.shortmess = o.shortmess + "O" -- file-read message overwrites previous
o.shortmess = o.shortmess + "T" -- truncate non-file messages in middle
o.shortmess = o.shortmess + "W" -- don't echo "[w]"/"[written]" when writing
o.shortmess = o.shortmess + "a" -- use abbreviations in messages eg. `[RO]` instead of `[readonly]`
o.shortmess = o.shortmess + "c" -- completion messages
o.shortmess = o.shortmess + "o" -- overwrite file-written messages
o.shortmess = o.shortmess + "t" -- truncate file messages at start
o.shortmess:append({ W = true, I = true, c = true, C = true })

-- make dirs for backup
cmd([[
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), 'p')
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), 'p')
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), 'p')
endif
]])
