return {
	{
		"folke/lazydev.nvim",
		dependencies = {
			"hrsh7th/nvim-cmp",
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
	{ -- optional cmp completion source for require statements and module annotations
		"hrsh7th/nvim-cmp",
		opts = function(_, opts)
			opts.sources = opts.sources or {}
			table.insert(opts.sources, {
				name = "lazydev",
				group_index = 0, -- set group index to 0 to skip loading LuaLS completions
			})
		end,
	},
	{
		"Bilal2453/luvit-meta",
		lazy = true,
	},
	-- { -- optional blink completion source for require statements and module annotations
	-- 	"saghen/blink.cmp",
	-- 	opts = {
	-- 		sources = {
	-- 			-- add lazydev to your completion providers
	-- 			completion = {
	-- 				enabled_providers = { "lsp", "path", "snippets", "buffer", "lazydev" },
	-- 			},
	-- 			providers = {
	-- 				-- dont show LuaLS require statements when lazydev has items
	-- 				lsp = { fallback_for = { "lazydev" } },
	-- 				lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
	-- 			},
	-- 		},
	-- 	},
	-- },
}
