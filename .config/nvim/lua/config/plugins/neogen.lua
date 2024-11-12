return {
	"danymat/neogen",
	config = function()
		require("neogen").setup({
			languages = {
				lua = {
					template = {
						annotation_convention = "emmylua", -- for a full list of annotation_conventions, see supported-languages below
					},
				},
			},
		})
	end,
}
