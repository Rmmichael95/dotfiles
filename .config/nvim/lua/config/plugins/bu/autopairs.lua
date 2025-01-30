return {
	"windwp/nvim-autopairs",
	event = { "InsertEnter" },
	-- dependencies = { "saghen/blink.cmp" },
	opts = {
		check_ts = true, -- enable treesitter
		ts_config = {
			lua = { "string" }, -- don't add pairs in lua string treesitter nodes
			javascript = { "template_string" }, -- don't add pairs in javascript template_string treesitter nodes
			java = false, -- don't check treesitter on java
		},
	},
	config = function(_, opts)
		-- import nvim-autopairs
		require("nvim-autopairs").setup(opts)
		-- require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
	end,
}
