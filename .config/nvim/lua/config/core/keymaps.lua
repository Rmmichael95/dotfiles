local map = vim.api.nvim_set_keymap
local cmd = vim.cmd -- vim command
local g = vim.g -- global variable

-- map the leader key
--map('n', '<Space>', '', {})
g.mapleader = " "
g.maplocalleader = "."

options = { noremap = true }
options_f = { noremap = false }

-- extended text objects
cmd([[
let items = [ "<bar>", "\\", "/", ":", ".", "*", "_" ]
for item in items
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
map("c", "w!!", "w !doas tee > /dev/null %", options_f)

-- Clear search with <esc>
--map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
	"n",
	"<leader>ur",
	"<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
	{ desc = "Redraw / Clear hlsearch / Diff Update" }
)

-- cnoremap
map("c", "<C-A>", "<Home>", options) -- bash like keys for the command line
map("c", "<C-E>", "<End>", options) -- bash like keys for the command line
map("c", "<C-K>", "<C-U>", options) -- bash like keys for the command line

map("c", "cd.", "lcd %:p:h<cr>", options) -- :cd. change working directory to that of the current file

map("c", "/", "/\v", options) -- use sane regexes
-- nnoremap
map("n", "<leader>y", ':if expand("%:e") == "h" | e %:r.cpp | else | e %:r.h | endif<CR>', options) -- switch between cpp/h files

map("n", "n", "nzzzv", options) -- keep search in center screen
map("n", "N", "Nzzzv", options) -- keep search in center screen
map("n", "H", "^", options) -- keep search in center screen
map("n", "L", "g", options) -- keep search in center screen
map("n", "g;", "g;zz", options) -- keep search in center screen
map("n", "g,", "g,zz", options) -- keep search in center screen
map("n", "<c-o>", "<c-o>zz", options) -- keep search in center screen

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

map("n", ";", ":", options) -- easy command mode
map("n", "V", "V`]", options) -- easy linewise reselection of what you just paste

map("n", "q:", "<nop>", options) -- disable cmd history popup
map("n", "Q", "<nop>", options) -- disable cmd history popup

map("n", "<leader>|", ":vsplit<CR>", options) -- easy vertical split
map("n", "<leader>-", ":split<CR>", options) -- easy horizontal split
map("n", "<leader>=", "<C-w>=", options) -- easy equal splits
map("n", "<C-J>", "<C-W><C-J>", options) -- ctrl-j to move down a split
map("n", "<C-K>", "<C-W><C-K>", options) -- ctrl-k to move up a split
map("n", "<C-L>", "<C-W><C-L>", options) -- ctrl-l to move right a split
map("n", "<C-H>", "<C-W><C-H>", options) -- ctrl-h to move left a split

map("n", "<C-t><C-t>", ":tabnew<CR>", options) -- easy new tab
map("n", "<C-t><C-z>", ":tabclose<CR>", options) -- easy close tab
map("n", "<C-t><C-n>", ":tabn<CR>", options) -- easy next tab
map("n", "<C-t><C-p>", ":tabp<CR>", options) -- easy prev tab

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

map("n", "<C-9>", ":bp<CR>", options) -- easy switch buffers
map("n", "<C-0>", ":bn<CR>", options) -- easy switch buffers
map("n", "<C-h>", "<C-w>h", options) -- easy buffer navigation
map("n", "<C-j>", "<C-w>j", options) -- easy buffer navigation
map("n", "<C-k>", "<C-w>k", options) -- easy buffer navigation
map("n", "<C-l>", "<C-w>l", options) -- easy buffer navigation
map("n", "vaa", "ggvGg_", options) -- select entire buffer
map("n", "Vaa", "ggVG", options) -- select entire buffer

-- Move Lines
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

map("n", ",q", ":q!<cr>", options) -- easy quit
map("n", ",w", ":w!<cr>", options) -- easy write
map("n", ",W", ":w!!<cr>", options) --
map("n", ",z", ":wq!<cr>", options) --

map("n", "Y", "y$", options) -- fix Y behaviour
map("n", "D", "d$", options) -- fix D behaviour

map("n", ",cd", ":cd %:p:h<CR>:pwd<CR>", options) -- change wd to where the file in the buffer is located w/ `,cd`

map("n", "<F9>", ":call myfuncs#CycleLang()<CR>", options) -- call my spell check function

map("n", "Vit", "vitVkoj", options) -- fix linewise visual selection of various text objects
map("n", "Vat", "vatV", options) -- fix linewise visual selection of various text objects
map("n", "Vab", "vabV", options) -- fix linewise visual selection of various text objects
map("n", "VaB", "vaBV", options) -- fix linewise visual selection of various text objects

map("n", "gI", "``.", options) -- gi moves to "last place you exited insert mode", map gI to move to last change

-- better up/down
-- map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
-- map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
-- map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
-- map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

--map('n', ',T', ':let _s=@/<Bar>:%s/\\s\\+$//e<Bar>%s/ \\+\\ze\\t//e<Bar>:let @/=_s<Bar>:unlet _s<CR>', options) -- trim whitespace before tabs and eol

-- inoremap
--map('i', '', '', options)

-- vnoremap
-- better indenting
map("v", "<", "<gv", options) -- allow multiple indentation in visual mode
map("v", ">", ">gv", options) -- allow multiple deindentation in visual mode

-- tnoremap
map("t", "<ESC>", "<C-\\><C-n><C-w><C-p>", options) -- <ESC> exits in terminal mode
