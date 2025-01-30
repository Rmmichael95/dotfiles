return {
	{
		"folke/lazydev.nvim",
		dependencies = {
			"mfussenegger/nvim-dap",
			"folke/snacks.nvim",
		},
		ft = "lua",
		cmd = "LazyDev",
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				{ path = "LazyVim", words = { "LazyVim" } },
				{ path = "snacks.nvim", words = { "Snacks" } },
				{ path = "lazy.nvim", words = { "LazyVim" } },
				{ path = "nvim-dap.nvim", words = { "nvim-dap-ui" } },
			},
		},
	},
	{
		"Bilal2453/luvit-meta",
		lazy = true,
	},
}
