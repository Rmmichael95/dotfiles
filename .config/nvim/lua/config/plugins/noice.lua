return {
	"folke/noice.nvim",
	dependencies = {
		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
		"MunifTanjim/nui.nvim",
	},
	event = "BufEnter",
	opts = {
		lsp = {
			progress = {
				enabled = false,
			},
		},
	},
}
