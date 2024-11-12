local cmd = vim.cmd
local u = require("config.utils")
local home = os.getenv("HOME")

local aucmd = vim.api.nvim_create_autocmd
-- local augroup = vim.api.nvim_create_augroup

-- commands

-- cmd([[command! -nargs=+ Foldsearch exe "normal /".<q-args>."^M" | setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\|\|(getline(v:lnum+1)=~@/)?1:2 foldmethod=expr foldlevel=0 foldcolumn=2]])
-- cmd([[command! -nargs=1 Ngrep lvimgrep "<args>" $NOTES_DIR/**/*.txt]])
-- cmd([[command! -range=% Rst :'<,'>!pandoc -f markdown -t rst]])

cmd(
	[[command! -bang -nargs=* Ag call fzf#vim#ag_interactive(<q-args>, fzf#vim#with_preview('right:50%:hidden', 'alt-h'))]]
)
cmd(
	[[command! -bang -nargs=* Rg call fzf#vim#rg_interactive(<q-args>, fzf#vim#with_preview('right:50%:hidden', 'alt-h'))]]
)

-- vertically center document when entering insert mode
cmd("autocmd InsertEnter * norm zz")

-- highlight whitespace before tabs and eol in darkred
-- cmd("highlight ExtraWhitespace guibg=darkred")
-- cmd([[autocmd BufEnter * match ExtraWhitespace /\s\+$\| \+\ze\t/]])
-- cmd("autocmd FileType dashboard highlight ExtraWhitespace guibg=0")

-- autocmds

local aucmd = vim.api.nvim_create_autocmd
-- local augroup = vim.api.nvim_create_augroup

-- toggle relative number off insert/on normal
u.create_augroup({
	{ "BufEnter,FocusGained,InsertLeave,WinEnter", "*", 'if &nu && mode() != "i" | set', "rnu   | endif" },
	{ "BufLeave,FocusLost,InsertEnter,WinLeave", "*", "if &nu                  | set", "nornu | endif" },
}, "numbertoggle")

-- auto reload vimrc when editing it
--cmd('autocmd bufwritepost init.lua source ~/.config/nvim/init.lua')
aucmd("bufwritepost", { command = "source " .. home .. "/.config/nvim/init.lua", pattern = "init.lua" })

-- open file with existing swp in readonly mode
----augroup()

u.create_augroup({
	{ "SwapExists", "*", "let", 'v:swapchoice = "o"' },
	{ "SwapExists", "*", "echomsg", "" },
	{ "SwapExists", "*", "echo", "Duplicate edit session (readonly)" },
	{ "SwapExists", "*", "echohl", "None" },
	{ "SwapExists", "*", "sleep", "2" },
}, "NoSimultaneousEdits")

-- aucmd('SwapExists', { group = swap })

aucmd("InsertEnter", { command = "norm zz" })

--aucmd('BufEnter', {command = 'match ExtraWhitespace /\\s\\+$\\| \\+\\ze\\t/'})
--aucmd("FileType dashboard", { command = "highlight ExtraWhitespace guibg=0" })
