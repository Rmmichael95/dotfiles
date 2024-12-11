return {
	"lukas-reineke/indent-blankline.nvim",
	event = "BufEnter",
	config = true,
	opts = function()
		-- Snacks.toggle({
		--   name = "Indentation Guides",
		--   get = function()
		--     return require("ibl.config").get_config(0).enabled
		--   end,
		--   set = function(state)
		--     require("ibl").setup_buffer(0, { enabled = state })
		--   end,
		-- }):map("<leader>ug")

		return {
			indent = {
				char = "│",
				tab_char = "│",
			},
			scope = { show_start = false, show_end = false },
			exclude = {
				filetypes = {
					"Trouble",
					"alpha",
					"dashboard",
					"help",
					"lazy",
					"mason",
					"neo-tree",
					"notify",
					"snacks_notif",
					"snacks_terminal",
					"snacks_win",
					"toggleterm",
					"trouble",
					"text",
					"txt",
					"csv",
					"tsv",
				},
			},
		}
	end,
	main = "ibl",
}
