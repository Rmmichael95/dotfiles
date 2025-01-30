return {
	"stevearc/conform.nvim",
	lazy = true,
	cmd = "ConformInfo",
	event = { "BufWritePost", "InsertLeave" },
	dependencies = {
		"williamboman/mason.nvim",
	},
	keys = {
		{
			"<leader>mp",
			function()
				require("conform").format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				})
			end,
			desc = "Format file or range (in visual mode)",
		},
	},
	config = function()
		require("conform").setup({
			formatters = {
				phpcbf = {
					-- command = vim.fn.stdpath("data") .. "/mason/bin/phpcbf",
					--command = "phpcbf",
					command = vim.fn.getcwd() .. "/vendor/bin/phpcbf",
					args = { "-q", "--standard=WordPress", "--report-json", "$FILENAME" },
				},
			},
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				svelte = { "prettier" },
				c = { "clang-format" },
				cpp = { "clang-format" },
				css = { "prettier" },
				php = { "phpcbf" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
				liquid = { "prettier" },
				lua = { "stylua" },
				python = { "isort", "black" },
				sh = { "shfmt" },
				["*"] = { "codespell" },
				["_"] = { "trim_whitespace" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			},
		})
	end,
}
