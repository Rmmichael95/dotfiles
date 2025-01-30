return {
	"danymat/neogen",
	keys = {
		{ "<Leader>ng", "<Cmd>lua require('neogen').generate()<CR>", desc = "Toggle Pin" },
	},
	opts = {
		languages = {
			lua = {
				template = {
					annotation_convention = "emmylua", -- for a full list of annotation_conventions, see supported-languages below
				},
			},
		},
	},
	config = function(_, opts)
		require("neogen").setup(opts)
	end,
}
