return {
	"stevearc/overseer.nvim",
	cmd = "Make",
	opts = {
		-- Default task strategy
		strategy = "terminal",
		-- Template modules to load
		templates = { "builtin" },
		-- Directories where overseer will look for template definitions (relative to rtp)
		template_dirs = { "overseer.template" },
		-- When true, tries to detect a green color from your colorscheme to use for success highlight
		auto_detect_success_color = true,
		-- Patch nvim-dap to support preLaunchTask and postDebugTask
		dap = true,
		-- Configure the task list
		task_list = {
			-- Default detail level for tasks. Can be 1-3.
			default_detail = 1,
			-- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
			-- min_width and max_width can be a single value or a list of mixed integer/float types.
			-- max_width = {100, 0.2} means "the lesser of 100 columns or 20% of total"
			max_width = { 100, 0.2 },
			-- min_width = {40, 0.1} means "the greater of 40 columns or 10% of total"
			min_width = { 40, 0.1 },
			-- optionally define an integer/float for the exact width of the task list
			width = nil,
			max_height = { 20, 0.1 },
			min_height = 8,
			height = nil,
			-- String that separates tasks
			separator = "────────────────────────────────────────",
			-- Default direction. Can be "left", "right", or "bottom"
			direction = "bottom",
			-- Set keymap to false to remove default behavior
			-- You can add custom keymaps here as well (anything vim.keymap.set accepts)
			bindings = {
				["?"] = "ShowHelp",
				["g?"] = "ShowHelp",
				["<CR>"] = "RunAction",
				["<C-e>"] = "Edit",
				["o"] = "Open",
				["<C-v>"] = "OpenVsplit",
				["<C-s>"] = "OpenSplit",
				["<C-f>"] = "OpenFloat",
				["<C-q>"] = "OpenQuickFix",
				["p"] = "TogglePreview",
				["<C-l>"] = "IncreaseDetail",
				["<C-h>"] = "DecreaseDetail",
				["L"] = "IncreaseAllDetail",
				["H"] = "DecreaseAllDetail",
				["["] = "DecreaseWidth",
				["]"] = "IncreaseWidth",
				["{"] = "PrevTask",
				["}"] = "NextTask",
				["<C-k>"] = "ScrollOutputUp",
				["<C-j>"] = "ScrollOutputDown",
				["q"] = "Close",
			},
		},
	},
	config = function(_, opts)
		require("overseer").setup(opts)
	end,
}
