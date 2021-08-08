local cmd = vim.cmd
local u = require('utils')

-- toggle relative number off insert/on normal
u.create_augroup({
    { 'BufEnter,FocusGained,InsertLeave,WinEnter', '*', 'if &nu && mode() != "i" | set', 'rnu   | endif' },
    { 'BufLeave,FocusLost,InsertEnter,WinLeave', '*',   'if &nu                  | set', 'nornu | endif' },
}, 'numbertoggle')

--cmd(autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif)
--cmd(autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif)

-- auto reload vimrc when editing it
cmd('autocmd bufwritepost init.lua source ~/.config/nvim/init.lua')

-- open file with existing swp in readonly mode
u.create_augroup({
    { 'SwapExists', '*', 'let', 'v:swapchoice = "o"' },
    { 'SwapExists', '*', 'echomsg', '' },
    { 'SwapExists', '*', 'echo', 'Duplicate edit session (readonly)' },
    { 'SwapExists', '*', 'echohl', 'None' },
    { 'SwapExists', '*', 'sleep', '2' },
}, 'NoSimultaneousEdits')

-- vertically center document when entering insert mode
cmd('autocmd InsertEnter * norm zz')

-- highlight whitespace before tabs and eol in darkred
cmd('highlight ExtraWhitespace guibg=darkred')
cmd([[autocmd BufEnter * match ExtraWhitespace /\s\+$\| \+\ze\t/]])
