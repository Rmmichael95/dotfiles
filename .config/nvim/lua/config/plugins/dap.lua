return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"nvim-treesitter/nvim-treesitter",
		"theHamsta/nvim-dap-virtual-text",
		"jay-babu/mason-nvim-dap.nvim",
	},
	config = function()
		local dap, ui = require("dap"), require("dapui")
		require("dapui").setup()

		require("dap").adapters.firefox = {
			type = "executable",
			command = "node",
			args = {
				vim.fn.stdpath("data") .. "/mason/bin/firefox-debug-adapter",
			},
		}

		require("dap").configurations.typescriptreact = {
			{
				name = "Debug with Firefox",
				type = "firefox",
				request = "launch",
				reAttach = true,
				url = "http://localhost:3000",
				webRoot = "${workspaceFolder}",
				firefoxExecutable = "/usr/bin/floorp", -- adjust to your Firefox executable path
			},
		}

		local keymap = vim.keymap -- for conciseness
		local opts = { silent = true }

		-- set keybinds
		opts.desc = "Toggle breakpoint"
		keymap.set("n", ",db", dap.toggle_breakpoint, opts)

		opts.desc = "DAP continue"
		keymap.set("n", ",dc", dap.continue, opts)

		opts.desc = "DAP step into"
		keymap.set("n", ",di", dap.step_into, opts)

		opts.desc = "DAP step over"
		keymap.set("n", ",ds", dap.step_over, opts)

		opts.desc = "DAP step out"
		keymap.set("n", ",dS", dap.step_out, opts)

		opts.desc = "DAP step back"
		keymap.set("n", ",dp", dap.step_back, opts)

		opts.desc = "DAP run to cursor"
		keymap.set("n", ",dh", dap.run_to_cursor, opts)

		-- Eval var under cursor
		opts.desc = "DAP eval under cursor"
		keymap.set("n", ",d?", function()
			require("dapui").eval(nil, { enter = true })
		end, opts)

		opts.desc = "DAP restart"
		keymap.set("n", ",dr", dap.restart, opts)

		opts.desc = "DAP-UI toggle"
		keymap.set("n", ",dt", ui.toggle, opts)

		dap.listeners.before.attach.dapui_config = function()
			ui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			ui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			ui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			ui.close()
		end

		require("nvim-dap-virtual-text").setup({
			enabled = true, -- enable this plugin (the default)
			enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
			highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
			highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
			show_stop_reason = true, -- show stop reason when stopped for exceptions
			commented = false, -- prefix virtual text with comment string
			only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
			all_references = false, -- show virtual text on all all references of the variable (not only definitions)
			clear_on_continue = false, -- clear virtual text on "continue" (might cause flickering when stepping)
			--- A callback that determines how a variable is displayed or whether it should be omitted
			--- @param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
			--- @param buf number
			--- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
			--- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
			--- @param options nvim_dap_virtual_text_options Current options for nvim-dap-virtual-text
			--- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
			display_callback = function(variable, buf, stackframe, node, options)
				-- by default, strip out new line characters
				if options.virt_text_pos == "inline" then
					return " = " .. variable.value:gsub("%s+", " ")
				else
					return variable.name .. " = " .. variable.value:gsub("%s+", " ")
				end
			end,
			-- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
			virt_text_pos = vim.fn.has("nvim-0.10") == 1 and "inline" or "eol",

			-- experimental features:
			all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
			virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
			virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
		})
	end,
}
