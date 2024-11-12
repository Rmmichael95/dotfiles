return {
	"nvim-tree/nvim-web-devicons",
	-- your personnal icons can go here (to override)
	-- you can specify color or cterm_color instead of specifying both of them
	-- DevIcon will be appended to `name`
	override = {
		zsh = {
			icon = "",
			color = "#a7c080",
			cterm_color = "65",
			name = "Zsh",
		},
	},
	-- globally enable default icons (default to false)
	-- will get overriden by `get_icons` option
	default = true,
}
