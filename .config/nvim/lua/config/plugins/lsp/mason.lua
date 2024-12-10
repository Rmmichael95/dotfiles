return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"jay-babu/mason-nvim-dap.nvim",
		"LittleEndianRoot/mason-conform",
		"rshkarin/mason-nvim-lint",
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
			"tailwindcss-language-server",
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
		-- doing lazy loading.
		integrations = {
			["mason-lspconfig"] = true,
			["mason-nvim-dap"] = true,
			["mason-conform"] = true,
			["mason-nvim-lint"] = true,
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
				-- cppdbg = function(config)
				-- 	config.adapters = {
				-- 		id = "cppdbg",
				-- 		type = "executable",
				-- 		command = vim.fn.stdpath("data") .. "/mason/bin/OpenDebugAD7",
				-- 	}
				-- 	mason_nvim_dap.default_setup(config)
				-- end,
			},
		})
	end,
}
