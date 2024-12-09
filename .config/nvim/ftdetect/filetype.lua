-- Filename: filetype.lua
-- Last Change: 09 Nov 2024

-- lua file detection feature:
-- https://github.com/neovim/neovim/pull/16600#issuecomment-990409210

-- filetype.lua is sourced before filetype.vim so any filetypes defined in
-- filetype.lua will take precedence.

-- on my init.lua i make a require to this file, so then I can place
-- it on my ~/.config/nvim/lua/config/core/ folder

--vim.g.do_filetype_lua = 1
--vim.g.did_load_filetypes = 0

vim.filetype.add({
	extension = {
		mp3 = "audio",
		flac = "audio",
		wav = "audio",
		ogg = "audio",
		opus = "audio",
		sh = "sh",
		zsh = "zsh",
		bash = "bash",
		fish = "fish",
		conf = "config",
		pbrt = "config",
		patch = "diff",
		rej = "diff",
		diff = "diff",
		erl = "erl",
		hs = "haskell",
		html = "html",
		png = "image",
		jpg = "image",
		jpeg = "image",
		js = "js",
		lua = "lua",
		md = "markdown",
		mmark = "markdown",
		r = "R",
		rs = "rust",
		perl = "perl",
		py = "python",
		wl = "mma",
		wls = "mma",
		scss = "scss.css",
		sass = "scss.css",
		sql = "sql",
		avi = "video",
		wmv = "video",
		flv = "video",
		mp4 = "video",
		mkv = "video",
		mov = "video",
		mpg = "video",
		vim = "vim",
		zig = "zig",
		c = "c",
		cpp = "cpp",
		h = function(path, bufnr)
			if vim.fn.search("\\C^#include <[^>.]\\+>$", "nw") ~= 0 then
				return "cpp"
			end
			return "c"
		end,
	},

	pattern = {
		["^\\.(?:zsh(?:rc|env)?)$"] = "sh",
		["*.*sh"] = "sh",
		["*.md.html"] = "markdown",
		[""] = "text",
		-- [".*"] = {
		--     function(path, bufnr)
		--         local content = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1] or ''
		--         if vim.regex([[^#!.*\\<mine\\>]]):match_str(content) ~= nil then
		--             return 'mine'
		--         elif vim.regex([[\\<drawing\\>]]):match_str(content) ~= nil then
		--             return 'drawing'
		--         end
		--     end,
		--     { priority = -math.huge },
		-- },
	},

	filename = {
		["*mutt-*"] = "mail",
		["TODO"] = "markdown",
		["/tmp/calcurse/notes*"] = "markdown",
		["~/calcurse*"] = "markdown",
		[".git/config"] = "gitconfig",
		["~/.config/zsh/.zshrc"] = "zsh",
		["~/.config/zsh/.zshenv"] = "zsh",
		["~/.config/zsh/.zprofile"] = "zsh",
		["~/.config/zsh/.zlogin"] = "zsh",
		["~/.local/state/zsh/history"] = "zsh",
		["~/.zshrc"] = "sh",
		["~/.config/mutt/muttrc"] = "muttrc",
		["README$"] = function(path, bufnr)
			if string.find("#", vim.api.nvim_buf_get_lines(bufnr, 0, 1, true)) then
				return "markdown"
			end
			-- no return means the filetype won't be set and to try the next method
		end,
	},
})
