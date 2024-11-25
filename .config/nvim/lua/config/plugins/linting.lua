return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile", "InsertLeave" },
	config = function()
		local lint = require("lint")
		local phpcs = lint.linters.phpcs
		phpcs.cmd = "/home/ryanm/.config/composer/vendor/bin/phpcs"
		phpcs.stdin = false
		phpcs.args = {
			"--standard=WordPress",
		}

		-- lint.phpcs = {
		-- 	cmd = "$XDG_CONFIG_HOME/composer/vendor/bin/phpcs",
		-- 	stdin = true,
		-- 	append_fname = true,
		-- 	args = { "-q", "--report=json", "--standard=WordPress", "-" },
		-- 	stream = nil,
		-- 	ignore_exitcode = false,
		-- 	env = nil,
		-- 	parser = lint.parser,
		-- }

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

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>ll", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
