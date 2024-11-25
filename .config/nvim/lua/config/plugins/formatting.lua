return {
	"stevearc/conform.nvim",
	lazy = false,
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"LittleEndianRoot/mason-conform",
	},
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters = {
				phpcbf = {
					command = "phpcbf",
					args = { "--standard=WordPress", "$FILENAME" },
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

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
