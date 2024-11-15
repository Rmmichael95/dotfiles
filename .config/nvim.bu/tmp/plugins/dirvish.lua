local M = {}
local g = vim.g     -- global variable
local cmd = vim.cmd -- vim command
local u = require('utils')
local map = vim.api.nvim_set_keymap

options   = { noremap = true }

g.loaded_netrwPlugin = 1

cmd([[command! -nargs=? -complete=dir Explore Dirvish <args>]])
cmd([[command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>]])
cmd([[command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>]])

u.create_augroup({
    { 'FileType', 'dirvish', 'nnoremap <silent><buffer> t', [[ddO<Esc>:let @"=substitute(@", '\n', '', 'g')<CR>:r ! find "<C-R>"" -maxdepth 1 -print0 \| xargs -0 ls -Fd<CR>:silent! keeppatterns %s/\/\//\//g<CR>:silent! keeppatterns %s/[^a-zA-Z0-9\/]$//g<CR>:silent! keeppatterns g/^$/d<CR>:noh<CR>]] },
}, 'dirvish_config')

g.netrw_banner = 0
g.netrw_liststyle = 3
g.netrw_browse_split = 4
g.netrw_altv = 1
g.netrw_winsize = 25

M.letExplore = function()
    if g.loaded_netrwPlugin then
        vim.api.nvim_command("Lexplore<CR>")
        g.loaded_netrwPlugin = 1
    else
        g.loaded_netrwPlugin = 0
        vim.api.nvim_command("Lexplore<CR>")
    end
    return M
end

--map('n', '<F2>', 'letExplore<CR>', options)  -- easy command mode
map('n', '<F2>', ':Dirvish<CR>', options)  -- easy command mode
