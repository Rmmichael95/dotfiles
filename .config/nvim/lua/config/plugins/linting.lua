return {
	"mfussenegger/nvim-lint",
	dependencies = {
		"williamboman/mason.nvim",
	},
	lazy = true,
	event = { "BufWritePost", "InsertLeave" },
	keys = {
		{
			"<leader>ll",
			function()
				require("lint").try_lint()
			end,
			desc = "Trigger linting for current file",
		},
	},
	config = function()
		local lint = require("lint")
		local phpcs = lint.linters.phpcs
		-- phpcs.cmd = vim.fn.stdpath("data") .. "/mason/bin/phpcs"
		phpcs.cmd = "phpcs"
		--phpcs.stdin = false
		phpcs.args = {
			"-q",
			"--standard=WordPress",
			"--report=json",
		}

		lint.linters_by_ft = {
			-- text = { "codespell" },
			-- markdown = { "markdownlint" },
			-- json = { "jsonlint" },
			-- css = { "stylelint" },
			-- scss = { "stylelint" },
			-- html = { "htmllint" },
			c = { "cpplint" },
			cpp = { "cpplint" },
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			svelte = { "eslint_d" },
			php = { "php", "phpcs" },
			python = { "pylint" },
			["*"] = { "codespell" },
		}

		-- local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
		--
		-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
		-- 	group = lint_augroup,
		-- 	callback = function()
		-- 		lint.try_lint()
		-- 	end,
		-- })
	end,
}
