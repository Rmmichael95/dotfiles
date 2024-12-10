return {
	"gbprod/substitute.nvim",
	keys = {
		{ "s", "<Cmd>require('substitute').operator<CR>", desc = "Substitute with motion" },
		{ "ss", "<Cmd>require('substitute').line<CR>", desc = "Substitute line" },
		{ "S", "<Cmd>require('substitute').eol<CR>", desc = "Substitute to end of line" },
		{ "s", "<Cmd>require('substitute').visual<CR>", desc = "Substitute in visual mode" },
	},
	config = function()
		require("substitute").setup()
	end,
}
