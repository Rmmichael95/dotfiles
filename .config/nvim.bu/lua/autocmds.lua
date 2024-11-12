local cmd = vim.cmd
local u = require('utils')
local home = os.getenv('HOME')

local aucmd = vim.api.nvim_create_autocmd
-- local augroup = vim.api.nvim_create_augroup

-- toggle relative number off insert/on normal
u.create_augroup({
    { 'BufEnter,FocusGained,InsertLeave,WinEnter', '*', 'if &nu && mode() != "i" | set', 'rnu   | endif' },
    { 'BufLeave,FocusLost,InsertEnter,WinLeave', '*',   'if &nu                  | set', 'nornu | endif' },
}, 'numbertoggle')

-- auto reload vimrc when editing it
--cmd('autocmd bufwritepost init.lua source ~/.config/nvim/init.lua')
aucmd('bufwritepost', { command = "source " .. home .. "/.config/nvim/init.lua", pattern = "init.lua" })

-- open file with existing swp in readonly mode
----augroup()

u.create_augroup({
    { 'SwapExists', '*', 'let', 'v:swapchoice = "o"' },
    { 'SwapExists', '*', 'echomsg', '' },
    { 'SwapExists', '*', 'echo', 'Duplicate edit session (readonly)' },
    { 'SwapExists', '*', 'echohl', 'None' },
    { 'SwapExists', '*', 'sleep', '2' },
}, 'NoSimultaneousEdits')

-- aucmd('SwapExists', { group = swap })

aucmd('InsertEnter', {command = 'norm zz'})

--aucmd('BufEnter', {command = 'match ExtraWhitespace /\\s\\+$\\| \\+\\ze\\t/'})
--aucmd('FileType dashboard', {command = 'highlight ExtraWhitespace guibg=0'})
