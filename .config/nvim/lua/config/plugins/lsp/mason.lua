return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"jay-babu/mason-nvim-dap.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	cmd = "Mason",
	keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
	build = ":MasonUpdate",
	opts = {
		ensure_installed = {
			-- LSP
			"clangd",
			"css-lsp",
			"html-lsp",
			"phpactor",
			"svelte-language-server",
			"bash-language-server",
			"intelephense",
			"lua-language-server",
			"typescript-language-server",
			"yaml-language-server",
			"r-languageserver",
			"rust-analyzer",
			"vim-language-server",
			"texlab",
			"zls",
			-- DAP
			"cpptools",
			"debugpy",
			"firefox-debug-adapter",
			"php-debug-adapter",
			-- conform
			"clang-format",
			"prettier", -- prettier formatter
			-- "phpcbf", -- php formatting w/code sniffer
			"stylua", -- lua formatter
			"isort", -- python formatter
			"black", -- python formatter
			-- lint
			"codespell",
			"cpplint",
			"phpcs",
			"pylint",
			"eslint_d",
		},
	},
	---@param opts MasonSettings | {ensure_installed: string[]}
	config = function(_, opts)
		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		require("mason-tool-installer").setup(opts)

		require("mason-nvim-dap").setup({
			handlers = {
				function(config)
					require("mason-nvim-dap").default_setup(config)
				end,
			},
		})
	end,
}
