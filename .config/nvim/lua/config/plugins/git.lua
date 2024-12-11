return {
	"dinhhuy258/git.nvim",
	config = true,
	keys = {
		{ "<leader>gb", "<cmd>lua require('git').blame()<CR>" },
		{ "<leader>go", "<cmd>lua require('git').browse()<CR>" },
		{ "<leader>gp", "<cmd>lua require('git').open_pull_request()<CR>" },
		{ "<leader>gn", "<cmd>lua require('git').create_pull_request()<CR>" },
		{ "<leader>gd", "<cmd>lua require('git').diff()<CR>" },
		{ "<leader>gD", "<cmd>lua require('git').diff_close()<CR>" },
		{ "<leader>gr", "<cmd>lua require('git').revert()<CR>" },
		{ "<leader>gR", "<cmd>lua require('git').revert_file()<CR>" },
	},
	opts = {
		default_mappings = true, -- NOTE: `quit_blame` and `blame_commit` are still merged to the keymaps even if `default_mappings = false`
	},
	-- config = function(_, opts)
	-- 	require("git").setup(opts)
	-- end,
}
