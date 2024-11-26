return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"jay-babu/mason-nvim-dap.nvim",
		"LittleEndianRoot/mason-conform",
		"rshkarin/mason-nvim-lint",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- local mason_lspconfig = require("mason-lspconfig")

		-- local mason_dap = require("mason-nvim-dap")

		-- local mason_conform = require("mason-conform")

		-- local mason_lint = require("mason-nvim-lint")

		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_tool_installer.setup({
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
		})
	end,
}
