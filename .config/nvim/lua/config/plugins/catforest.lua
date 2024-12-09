return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "macchiato", -- latte, frappe, macchiato, mocha
			background = { -- :h background
				light = "latte",
				dark = "mocha",
			},
			transparent_background = true, -- disables setting the background color.
			show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
			term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
			dim_inactive = {
				enabled = false, -- dims the background color of inactive window
				shade = "dark",
				percentage = 0.15, -- percentage of the shade to apply to the inactive window
			},
			no_italic = false, -- Force no italic
			no_bold = false, -- Force no bold
			no_underline = false, -- Force no underline
			styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
				comments = { "italic" }, -- Change the style of comments
				conditionals = { "italic" },
				loops = {},
				functions = {},
				keywords = {},
				strings = {},
				variables = {},
				numbers = {},
				booleans = {},
				properties = {},
				types = {},
				operators = {},
				-- miscs = {}, -- Uncomment to turn off hard-coded styles
			},
			color_overrides = {
				-- catppuccin macchiato
				-- rosewater = "#f4dbd6",
				-- flamingo = "#f0c6c6",
				-- pink = "#f5bde6",
				-- mauve = "#c6a0f6",
				-- red = "#ed8796",
				-- maroon = "#ee99a0",
				-- peach = "#f5a97f",
				-- yellow = "#eed49f",
				-- green = "#a6da95",
				-- teal = "#8bd5ca",
				-- sky = "#91d7e3",
				-- sapphire = "#7dc4e4",
				-- blue = "#8aadf4",
				-- lavender = "#b7bdf8",
				-- text = "#cad3f5",
				-- subtext1 = "#b8c0e0",
				-- subtext0 = "#a5adcb",
				-- overlay2 = "#939ab7",
				-- overlay1 = "#8087a2",
				-- overlay0 = "#6e738d",
				-- surface2 = "#5b6078",
				-- surface1 = "#494d64",
				-- surface0 = "#363a4f",
				-- base = "#24273a",
				-- mantle = "#1e2030",
				-- crust = "#181926",
				-- everforest dark medium
				-- fg = "#d3c6aa",
				-- red = "#e67e80",
				-- orange = "#e69875",
				-- yellow = "#dbbc7f",
				-- green = "#a7c080",
				-- aqua = "#83c092",
				-- blue = "#7fbbb3",
				-- purple = "#d699b6",
				-- grey0 = "#7a8478",
				-- grey1 = "#859289",
				-- grey2 = "#9da9a0",
				-- bg_dim = "#1e2326",
				-- bg0 = "#272e33",
				-- bg1 = "#2e383c",
				-- bg2 = "#374145",
				-- bg3 = "#414b50",
				-- bg4 = "#495156",
				-- bg5 = "#4f5b58",

				-- catforest
				macchiato = {
					red = "#e67e80",
					maroon = "#ed8796",
					peach = "#e69875",
					yellow = "#dbbc7f",
					green = "#a7c080",
					teal = "#83c092",
					blue = "#7fbbb3",
					sapphire = "#8bd5ca",
					mauve = "#d699b6",
					-- lavender = "#c6a0f6",
					-- text = "#f4dbd6",
					-- subtext1 = "#d3c6aa",
					-- subtext0 = "#cad3f5",
					overlay2 = "#7a8478",
					-- overlay1 = "#859289",
					-- overlay0 = "#9da9a0",
					-- surface2 = "#495156",
					-- surface1 = "#414b50",
					-- surface0 = "#374145",
					-- base = "#2e383c",
					-- mantle = "#272e33",
					-- crust = "#1e2326",
				},
			},
			-- play nice with redshift
			custom_highlights = function(colors)
				return {
					Boolean = { fg = "#d699b6" },
					Number = { fg = "#d699b6" },
					Float = { fg = "#d699b6" },
					PreProc = { fg = "#d699b6" },
					PreCondit = { fg = "#d699b6" },
					Include = { fg = "#d699b6" },
					Define = { fg = "#d699b6" },
					Conditional = { fg = "#e67e80" },
					Repeat = { fg = "#e67e80" },
					Keyword = { fg = "#e67e80" },
					Typedef = { fg = "#e67e80" },
					Exception = { fg = "#e67e80" },
					Statement = { fg = "#e67e80" },
					Error = { fg = "#e67e80" },
					StorageClass = { fg = "#e69875" },
					Tag = { fg = "#e69875" },
					Label = { fg = "#e69875" },
					Structure = { fg = "#e69875" },
					Operator = { fg = "#e69875" },
					Special = { fg = "#dbbc7f" },
					SpecialChar = { fg = "#dbbc7f" },
					Type = { fg = "#dbbc7f" },
					Function = { fg = "#a7c080" },
					String = { fg = "#a7c080" },
					Character = { fg = "#a7c080" },
					Constant = { fg = "#83c092" },
					Macro = { fg = "#83c092" },
					Identifier = { fg = "#83c092" },
				}
			end,
			default_integrations = true,
			integrations = {
				cmp = true,
				gitsigns = true,
				nvimtree = true,
				treesitter = true,
				notify = false,
				mini = {
					enabled = true,
					indentscope_color = "",
				},
				-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
			},
		})
		-- setup must be called before loading
		vim.cmd.colorscheme("catppuccin")
	end,
}
