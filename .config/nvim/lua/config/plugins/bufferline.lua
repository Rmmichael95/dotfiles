return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	optional = true,
	opts = {
		options = {
			mode = "tabs",
			seperator_style = "slant",
		},
	},
	opts = function(_, opts)
		if (vim.g.colors_name or ""):find("everforest") then
			opts.highlights = require("everforest.groups.integrations.bufferline").get()
		end
	end,
}
