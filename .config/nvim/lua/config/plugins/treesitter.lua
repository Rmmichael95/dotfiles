return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	opts = {
		-- A list of parser names, or "all" (the listed parsers MUST always be installed)
		-- ensure these language parsers are installed
		ensure_installed = {
			"json",
			"javascript",
			"typescript",
			"tsx",
			"yaml",
			"html",
			"css",
			"markdown",
			"markdown_inline",
			"bash",
			"lua",
			"vim",
			"dockerfile",
			"gitignore",
			"query",
			"vimdoc",
			"c",
			"cpp",
			"zig",
		},
		-- ensure_installed = { "all" },

		-- Install parsers synchronously (only applied to `ensure_installed`)
		sync_install = false,

		-- Automatically install missing parsers when entering buffer
		-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
		auto_install = true,

		highlight = {
			enable = true,

			-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
			-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
			-- Using this option may slow down your editor, and you may see some duplicate highlights.
			-- Instead of true it can also be a list of languages
			additional_vim_regex_highlighting = false,
		},
		indent = { enable = true },
		textobjects = {
			select = {
				enable = true,

				-- Automatically jump forward to textobj, similar to targets.vim
				lookahead = true,

				keymaps = {
					-- You can use the capture groups defined in textobjects.scm
					["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
					["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
					["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
					["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

					-- works for javascript/typescript files (custom capture I created in after/queries/ecma/textobjects.scm)
					["a:"] = { query = "@property.outer", desc = "Select outer part of an object property" },
					["i:"] = { query = "@property.inner", desc = "Select inner part of an object property" },
					["l:"] = { query = "@property.lhs", desc = "Select left part of an object property" },
					["r:"] = { query = "@property.rhs", desc = "Select right part of an object property" },

					["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
					["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

					["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
					["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

					["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
					["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

					["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
					["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },

					["am"] = {
						query = "@function.outer",
						desc = "Select outer part of a method/function definition",
					},
					["im"] = {
						query = "@function.inner",
						desc = "Select inner part of a method/function definition",
					},

					["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
					["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
				},
			},
			swap = {
				enable = true,
				swap_next = {
					["<leader>na"] = "@parameter.inner", -- swap parameters/argument with next
					["<leader>n:"] = "@property.outer", -- swap object property with next
					["<leader>nm"] = "@function.outer", -- swap function with next
				},
				swap_previous = {
					["<leader>pa"] = "@parameter.inner", -- swap parameters/argument with prev
					["<leader>p:"] = "@property.outer", -- swap object property with prev
					["<leader>pm"] = "@function.outer", -- swap function with previous
				},
			},
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					["]f"] = { query = "@call.outer", desc = "Next function call start" },
					["]m"] = { query = "@function.outer", desc = "Next method/function def start" },
					["]c"] = { query = "@class.outer", desc = "Next class start" },
					["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
					["]l"] = { query = "@loop.outer", desc = "Next loop start" },

					-- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
					-- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
					["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
					["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
				},
				goto_next_end = {
					["]F"] = { query = "@call.outer", desc = "Next function call end" },
					["]M"] = { query = "@function.outer", desc = "Next method/function def end" },
					["]C"] = { query = "@class.outer", desc = "Next class end" },
					["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
					["]L"] = { query = "@loop.outer", desc = "Next loop end" },
				},
				goto_previous_start = {
					["[f"] = { query = "@call.outer", desc = "Prev function call start" },
					["[m"] = { query = "@function.outer", desc = "Prev method/function def start" },
					["[c"] = { query = "@class.outer", desc = "Prev class start" },
					["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
					["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
				},
				goto_previous_end = {
					["[F"] = { query = "@call.outer", desc = "Prev function call end" },
					["[M"] = { query = "@function.outer", desc = "Prev method/function def end" },
					["[C"] = { query = "@class.outer", desc = "Prev class end" },
					["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
					["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
				},
			},
		},
	},

	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)

		require("nvim-ts-autotag").setup({
			opts = {
				-- Defaults
				enable_close = true, -- Auto close tags
				enable_rename = true, -- Auto rename pairs of tags
				enable_close_on_slash = true, -- Auto close on trailing </
			},
		})

		local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

		-- vim way: ; goes to the direction you were moving.
		vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
		vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

		-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
		vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
		vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
		vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
		vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
	end,
}
