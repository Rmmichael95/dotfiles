return {
	"HiPhish/rainbow-delimiters.nvim",
	lazy = false,
	config = function()
		local rainbow_delimiters = require("rainbow-delimiters")
		require("rainbow-delimiters.setup").setup({
			strategy = {
				[""] = rainbow_delimiters.strategy["global"],
				vim = rainbow_delimiters.strategy["local"],
			},
			query = {
				[""] = "rainbow-delimiters",
				lua = "rainbow-blocks",
			},
			priority = {
				[""] = 110,
				lua = 210,
			},
			highlight = {
				"RainbowDelimiterRed",
				"RainbowDelimiterViolet",
				"RainbowDelimiterCyan",
				"RainbowDelimiterOrange",
				"RainbowDelimiterBlue",
				"RainbowDelimiterGreen",
				"RainbowDelimiterYellow",
			},
		})
	end,
}
