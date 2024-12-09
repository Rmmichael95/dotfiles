local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- map the leader key
--map('n', '<Space>', '', {})
vim.g.mapleader = " "
vim.g.maplocalleader = "."

-- extended text objects
vim.cmd([[
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
map("c", "w!!", "w !doas tee > /dev/null %", { noremap = false, desc = "Save as SUDO" })

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
map("c", "<C-A>", "<Home>") -- bash like keys for the command line
map("c", "<C-E>", "<End>") -- bash like keys for the command line
map("c", "<C-K>", "<C-U>") -- bash like keys for the command line

map("c", "cd.", "<Cmd>lcd %:p:h<CR>") -- :cd. change working directory to that of the current file

map("c", "/", "/\v") -- use sane regexes
-- nnoremap
map("n", "<leader>y", ':if expand("%:e") == "h" | e %:r.cpp | else | e %:r.h | endif<CR>') -- switch between cpp/h files

map("n", "n", "nzzzv") -- keep search in center screen
map("n", "N", "Nzzzv") -- keep search in center screen
map("n", "H", "^") -- keep search in center screen
map("n", "L", "g") -- keep search in center screen
map("n", "g;", "g;zz") -- keep search in center screen
map("n", "g,", "g,zz") -- keep search in center screen
map("n", "<c-o>", "<c-o>zz") -- keep search in center screen

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

map("n", ";", ":") -- easy command mode
map("n", "V", "V`]") -- easy linewise reselection of what you just paste

map("n", "q:", "<nop>") -- disable cmd history popup
map("n", "Q", "<nop>") -- disable cmd history popup

map("n", "<leader>|", "<Cmd>vsplit<CR>") -- easy vertical split
map("n", "<leader>-", "<Cmd>split<CR>") -- easy horizontal split
map("n", "<leader>=", "<C-w>=") -- easy equal splits
map("n", "<C-J>", "<C-W><C-J>") -- ctrl-j to move down a split
map("n", "<C-K>", "<C-W><C-K>") -- ctrl-k to move up a split
map("n", "<C-L>", "<C-W><C-L>") -- ctrl-l to move right a split
map("n", "<C-H>", "<C-W><C-H>") -- ctrl-h to move left a split

map("n", "<C-t><C-t>", "<Cmd>tabnew<CR>") -- easy new tab
map("n", "<C-t><C-z>", "<Cmd>tabclose<CR>") -- easy close tab
map("n", "<C-t><C-n>", "<Cmd>tabn<CR>") -- easy next tab
map("n", "<C-t><C-p>", "<Cmd>tabp<CR>") -- easy prev tab

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<Cmd>resize +2<CR>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<Cmd>resize -2<CR>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<Cmd>vertical resize -2<CR>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<Cmd>vertical resize +2<CR>", { desc = "Increase Window Width" })

map("n", "<C-9>", ":bp<CR>") -- easy switch buffers
map("n", "<C-0>", ":bn<CR>") -- easy switch buffers
map("n", "<C-h>", "<C-w>h") -- easy buffer navigation
map("n", "<C-j>", "<C-w>j") -- easy buffer navigation
map("n", "<C-k>", "<C-w>k") -- easy buffer navigation
map("n", "<C-l>", "<C-w>l") -- easy buffer navigation
map("n", "vaa", "ggvGg_") -- select entire buffer
map("n", "Vaa", "ggVG") -- select entire buffer

-- Move Lines
map("n", "<A-j>", "<Cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<Cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><Cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><Cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", "<Cmd><C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", "<Cmd><C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

map("n", ",q", "<Cmd>q!<CR>") -- easy quit
map("n", ",w", "<Cmd>w!<CR>") -- easy write
map("n", ",W", "<Cmd>w!!<CR>") --
map("n", ",z", "<Cmd>wq!<CR>") --

map("n", "Y", "y$") -- fix Y behaviour
map("n", "D", "d$") -- fix D behaviour

map("n", ",cd", "<Cmd>cd %:p:h<CR>:pwd<CR>") -- change wd to where the file in the buffer is located w/ `,cd`

map("n", "<F9>", "<Cmd>call myfuncs#CycleLang()<CR>") -- call my spell check function

map("n", "Vit", "vitVkoj") -- fix linewise visual selection of various text objects
map("n", "Vat", "vatV") -- fix linewise visual selection of various text objects
map("n", "Vab", "vabV") -- fix linewise visual selection of various text objects
map("n", "VaB", "vaBV") -- fix linewise visual selection of various text objects

map("n", "gI", "``.") -- gi moves to "last place you exited insert mode", map gI to move to last change

map("n", "<leader>c", '<Cmd>w! | !compiler "%:p"<CR>')

-- better up/down
-- map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
-- map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
-- map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
-- map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

--map('n', ',T', ':let _s=@/<Bar>:%s/\\s\\+$//e<Bar>%s/ \\+\\ze\\t//e<Bar>:let @/=_s<Bar>:unlet _s<CR>', opts) -- trim whitespace before tabs and eol

-- inoremap
--map('i', '', '')

-- vnoremap
-- better indenting
map("v", "<", "<gv") -- allow multiple indentation in visual mode
map("v", ">", ">gv") -- allow multiple deindentation in visual mode

-- tnoremap
map("t", "<ESC>", "<C-\\><C-n><C-w><C-p>") -- <ESC> exits in terminal mode
