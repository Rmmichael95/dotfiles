local map = vim.api.nvim_set_keymap
local cmd = vim.cmd -- vim command
local g = vim.g     -- global variable

-- map the leader key
map('n', '<Space>', '', {})
g.mapleader = ' '

options   = { noremap = true }
options_f = { noremap = false }

-- extended text objects
cmd([[
let s:items = [ "<bar>", "\\", "/", ":", ".", "*", "_" ]
for item in s:items
  exe "nnoremap yi".item." T".item."yt".item
  exe "nnoremap ya".item." F".item."yf".item
  exe "nnoremap ci".item." T".item."ct".item
  exe "nnoremap ca".item." F".item."cf".item
  exe "nnoremap di".item." T".item."dt".item
  exe "nnoremap da".item." F".item."df".item
  exe "nnoremap vi".item." T".item."vt".item
  exe "nnoremap va".item." F".item."vf".item
endfor
]])

-- cmap
map('c', 'w!!', 'w !sudo tee > /dev/null %', options_f)
map('c', '', '', options_f)
-- noremap
map('*', '<C-t><C-t>', ':tabnew<CR>', options)       -- easy new tab
map('*', '<C-t><C-z>', ':tabclose<CR>', options)     -- easy close tab
map('*', '<C-9>', ':bp<CR>', options)                -- easy switch buffers
map('*', '<C-0>', ':bn<CR>', options)                -- easy switch buffers
map('*', '<C-h>', '<C-w>h', options)                 -- easy buffer navigation
map('*', '<C-j>', '<C-w>j', options)                 -- easy buffer navigation
map('*', '<C-k>', '<C-w>k', options)                 -- easy buffer navigation
map('*', '<C-l>', '<C-w>l', options)                 -- easy buffer navigation
map('*', 'n', 'nzzzv', options)                      -- keep search in center screen
map('*', 'N', 'Nzzzv', options)                      -- keep search in center screen
map('*', 'H', '^', options)                          -- keep search in center screen
map('*', 'L', 'g', options)                          -- keep search in center screen
-- cnoremap
map('c', '<C-A>', '<Home>', options)                -- bash like keys for the command line
map('c', '<C-E>', '<End>', options)                 -- bash like keys for the command line
map('c', '<C-K>', '<C-U>', options)                 -- bash like keys for the command line
map('c', 'cd.', 'lcd %:p:h<cr>', options)           -- :cd. change working directory to that of the current file
-- nnoremap
map('n', ';', ':', options)                         -- easy command mode
map('n', 'V', 'V`]', options)                       -- easy linewise reselection of what you just paste
map('n', '<leader>v', ':vsplit<CR>', options)       -- easy virtical split
map('n', '<leader>h', ':split<CR>', options)        -- easy horizontal split
map('n', '<C-J>', '<C-W><C-J>', options)            -- ctrl-j to move down a split
map('n', '<C-K>', '<C-W><C-K>', options)            -- ctrl-k to move up a split
map('n', '<C-L>', '<C-W><C-L>', options)            -- ctrl-l to move    right a split
map('n', '<C-H>', '<C-W><C-H>', options)            -- ctrl-h to move left a split
map('n', ',q', ':q!<cr>', options)                  -- easy quit
map('n', ',w', ':w!<cr>', options)                  -- easy write
map('n', ',W', ':w!!<cr>', options)                 -- 
map('n', ',z', ':wq!<cr>', options)                 --
map('n', '<leader>\', ':TagbarToggle<CR>', options) --
map('n', '<leader>y', ':FSHere<cr>', options)       --
map('n', '/', '/\v', options)                       -- use sane regexes
map('n', 'Y', 'y$', options)                        -- fix Y behaviour
map('n', 'D', 'd$', options)                        -- fix D behaviour
map('n', ',cd', ':cd %:p:h<CR>:pwd<CR>', options)   -- change wd to where the file in the buffer is located w/ `,cd`
map('n', '<F9>', ':call myfuncs#CycleLang()<CR>', options) -- call my spell check function
map('n', 'g;', 'g;zz', options)                     -- keep search in center screen
map('n', 'g,', 'g,zz', options)                     -- keep search in center screen
map('n', '<c-o>', '<c-o>zz', options)               -- keep search in center screen
map('n', 'Vit', 'vitVkoj', options)                 -- fix linewise visual selection of various text objects
map('n', 'Vat', 'vatV', options)                    -- fix linewise visual selection of various text objects
map('n', 'Vab', 'vabV', options)                    -- fix linewise visual selection of various text objects
map('n', 'VaB', 'vaBV', options)                    -- fix linewise visual selection of various text objects
map('n', 'vaa', 'ggvGg_', options)                  -- select entire buffer
map('n', 'Vaa', 'ggVG', options)                    -- select entire buffer
map('n', 'gI', '``.', options)                      -- gi moves to "last place you exited insert mode", map gI to move to last change
map('n', ',T', ':let _s=@/<Bar>:%s/\\s\\+$//e<Bar>%s/ \\+\\ze\\t//e<Bar>:let @/=_s<Bar>:unlet _s<CR>', options) -- trim whitespace before tabs and eol
-- inoremap
map('i', '', '', options)
-- vnoremap
map('v', '<', '<gv', options)                       -- allow multiple indentation in visual mode
map('v', '>', '>gv', options)                       -- allow multiple deindentation in visual mode
map('v', '/', '/\v', options)                       -- use sane regexes
-- tnoremap
map('t', '<ESC>', '<C-\><C-n><C-w><C-p>', options)  -- <ESC> exits in terminal mode
