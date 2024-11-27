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

		require("nvim-dap-virtual-text").setup({})
	end,
}
