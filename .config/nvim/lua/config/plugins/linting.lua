return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile", "InsertLeave" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {

			codespell = { "md", "txt" },
			eslint = { "js", "jsx", "ts", "tsx" },
			tidy = { "html" },
			jsonlint = { "json" },
			markdownlint = { "md" },
			php = { "php" },
			phpcs = { "php" },
			pylint = { "py" },
			stylelint = { "css", "scss", "less" },
		}

		-- lint.linters_by_ft = {
		-- 	-- text = { "codespell" },
		-- 	-- markdown = { "markdownlint" },
		-- 	-- json = { "jsonlint" },
		-- 	-- css = { "stylelint" },
		-- 	-- scss = { "stylelint" },
		-- 	-- html = { "htmllint" },
		-- 	javascript = { "eslint_d" },
		-- 	typescript = { "eslint_d" },
		-- 	javascriptreact = { "eslint_d" },
		-- 	typescriptreact = { "eslint_d" },
		-- 	svelte = { "eslint_d" },
		-- 	php = { "php" },
		-- 	phpcs = { "php" },
		-- 	python = { "pylint" },
		-- }

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
