return {
	"justinmk/vim-dirvish", -- replacement for netrw
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"kristijanhusak/vim-dirvish-git", -- add git bloat to dirvish
		"bounceme/remote-viewer", -- add remote fs support to dirvish; now it's really netrw
		"tpope/vim-eunuch", -- Unix commands in vim; useful for dirvish
	},
	lazy = false,
	config = function()
		local g = vim.g -- global variable
		local a = vim.api
		local cmd = vim.cmd -- vim command
		local u = require("config.utils")
		local map = vim.keymap.set

		options = { noremap = true }

		cmd([[command! -nargs=? -complete=dir Explore Dirvish <args>]])
		cmd([[command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>]])
		cmd([[command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>]])

		-- u.nvim_create_autocmd( { "FileType" }, {
		--     pattern = { "dirvish" },
		-- })

		u.create_augroup({
			{
				"FileType",
				"dirvish",
				"nnoremap <silent><buffer> t",
				[[ddO<Esc>:let @"=substitute(@", '\n', '', 'g')<CR>:r ! find "<C-R>"" -maxdepth 1 -print0 \| xargs -0 ls -Fd<CR>:silent! keeppatterns %s/\/\//\//g<CR>:silent! keeppatterns %s/[^a-zA-Z0-9\/]$//g<CR>:silent! keeppatterns g/^$/d<CR>:noh<CR>]],
			},
		}, "dirvish_config")

		map("n", "<F2>", function()
			if g.loaded_netrwPlugin then
				a.nvim_command("Vexplore<CR>")
				g.loaded_netrwPlugin = 1
			else
				g.loaded_netrwPlugin = 0
				a.nvim_command("Vexplore<CR>")
			end
		end, options)
	end,
}
