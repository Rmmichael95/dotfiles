return {
	"L3MON4D3/LuaSnip",
	-- follow latest release.
	version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- install jsregexp (optional!).
	build = "make install_jsregexp",
	dependencies = {
		"rafamadriz/friendly-snippets",
		-- "molleweide/luasnip-snippets.nvim",
		-- "stevearc/vim-vscode-snippets",
	},
	config = function()
		-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
		require("luasnip.loaders.from_vscode").lazy_load()
		require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
		require("luasnip").filetype_extend("php", { "html" })
		require("luasnip").filetype_extend("php", { "css" })
	end,
}
