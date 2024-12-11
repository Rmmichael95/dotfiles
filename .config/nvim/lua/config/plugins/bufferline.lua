return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = { "BufAdd", "BufDelete" },
	config = true,
	opts = {
		options = {
			mode = "tabs", -- set to "tabs" to only show tabpages instead
			-- style_preset = bufferline.style_preset.default, -- or bufferline.style_preset.minimal,
			themable = true, -- allows highlight groups to be overridden i.e. sets highlights as default
			numbers = "both",
			close_command = function(n)
				Snacks.bufdelete(n)
			end,
			right_mouse_command = function(n)
				Snacks.bufdelete(n)
			end,
			indicator = {
				style = "underline",
			},
			buffer_close_icon = "󰅖",
			modified_icon = "● ",
			close_icon = " ",
			left_trunc_marker = " ",
			right_trunc_marker = " ",
			max_name_length = 18,
			max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
			truncate_names = true, -- whether or not tab names should be truncated
			tab_size = 18,
			diagnostics = "nvim_lsp",
			diagnostics_update_in_insert = false, -- only applies to coc
			diagnostics_update_on_event = true, -- use nvim's diagnostic handler
			-- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
			diagnostics_indicator = function(count, level, diagnostics_dict, context)
				return "(" .. count .. ")"
			end,
			show_buffer_icons = true, -- disable filetype icons for buffers
			show_buffer_close_icons = true,
			show_close_icon = true,
			show_tab_indicators = true,
			show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
			duplicates_across_groups = true, -- whether to consider duplicate paths in different groups as duplicates
			persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
			move_wraps_at_ends = false, -- whether or not the move command "wraps" at the first or last position
			separator_style = "slope",
			enforce_regular_tabs = false,
			always_show_bufferline = false,
			hover = {
				enabled = true,
				delay = 200,
				reveal = { "close" },
			},
			-- sort_by = "insert_after_current",
			function(buffer_a, buffer_b)
				-- add custom logic
				local modified_a = vim.fn.getftime(buffer_a.path)
				local modified_b = vim.fn.getftime(buffer_b.path)
				return modified_a > modified_b
			end,
			pick = {
				alphabet = "abcdefghijklmopqrstuvwxyzABCDEFGHIJKLMOPQRSTUVWXYZ1234567890",
			},
		},
	},
	-- config = function(_, opts)
	-- 	require("bufferline").setup(opts)
	-- 	-- Fix bufferline when restoring a session
	-- 	vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
	-- 		callback = function()
	-- 			vim.schedule(function()
	-- 				pcall(nvim_bufferline)
	-- 			end)
	-- 		end,
	-- 	})
	-- end,
}
