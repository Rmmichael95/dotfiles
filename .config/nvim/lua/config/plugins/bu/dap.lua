return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"folke/lazydev.nvim",
		"nvim-treesitter/nvim-treesitter",
		"theHamsta/nvim-dap-virtual-text",
		"jay-babu/mason-nvim-dap.nvim",
	},
	config = function()
		local mason_nvim_dap = require("mason-nvim-dap")
		mason_nvim_dap.setup({
			ensure_installed = {},
			automatic_installation = false,
			handlers = {
				function(config)
					mason_nvim_dap.default_setup(config)
				end,
				cppdbg = function(config)
					config.adapters = {
						id = "cppdbg",
						type = "executable",
						command = "/home/ryanm/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
					}
					mason_nvim_dap.default_setup(config)
				end,
			},
		})

		local dap, dapui = require("dap"), require("dapui")
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		-- dap.adapters.cppdbg = {
		-- 	id = "cppdbg",
		-- 	type = "executable",
		-- 	command = "/home/ryanm/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
		-- }
		dap.configurations.cpp = {
			{
				name = "Launch file",
				type = "cppdbg",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopAtEntry = true,
			},
			{
				name = "Attach to gdbserver :1234",
				type = "cppdbg",
				request = "launch",
				MIMode = "gdb",
				miDebuggerServerAddress = "localhost:1234",
				miDebuggerPath = "/usr/bin/gdb",
				cwd = "${workspaceFolder}",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
			},
		}
		dap.configurations.c = dap.configurations.cpp
		dap.configurations.rust = dap.configurations.cpp

		local n = "n"
		vim.keymap.set(n, "<leader>dk", function()
			require("dap").continue()
		end)
		vim.keymap.set(n, "<leader>dl", function()
			require("dap").run_last()
		end)
		vim.keymap.set(n, "<leader>B", function()
			require("dap").toggle_breakpoint()
		end)

		vim.keymap.set(n, "<leader>tD", function()
			require("dapui").toggle()
		end)

		local virtualt = require("nvim-dap-virtual-text")
		virtualt.setup({
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
			-- e.g.
		})

		local lazydev = require("lazydev")
		lazydev.setup({
			library = {
				"nvim-dap-ui",
			},
		})
	end,
}
