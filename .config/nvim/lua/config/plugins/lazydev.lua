return {
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				"nvim-dap-ui",
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
}
