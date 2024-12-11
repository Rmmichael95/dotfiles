return {
	{
		"tpope/vim-eunuch", -- unix commands in vim (for netrw)
		cmd = {
			"Remove",
			"Delete",
			"Move",
			"Chmod",
			"Mkdir",
			"Cfile",
			"Clocate",
			"Lfine",
			"Llocate",
			"Wall",
			"SudoWrite",
			"SudoEdit",
		},
	},
	-- {
	-- 	"christoomey/vim-tmux-navigator", -- tmux & split window navigation
	-- },
	{
		"neomutt/neomutt.vim", -- syntax for mail
		ft = "mutt",
		lazy = true,
		config = true,
		opts = {},
	},
	{
		"elkowar/yuck.vim", -- syntax for eww bar yuck lisp configs
		ft = "yuck",
		lazy = true,
		config = true,
		opts = {},
	},
	{
		"easymotion/vim-easymotion", -- added text motions
	},
}
