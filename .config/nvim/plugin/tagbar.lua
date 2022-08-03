local map = vim.api.nvim_set_keymap
local g = vim.g

--vars
g.tagbar_width = 80
g.tagbar_sort = 0

--maps
map('n', '<leader>\\', ':TagbarToggle<CR>', options) --
