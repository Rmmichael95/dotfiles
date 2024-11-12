local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "neovim/nvim-lspconfig",                              -- config for nvim build in lsp
  "williamboman/mason.nvim",
  "glepnir/lspsaga.nvim",                               -- A light-weight lsp plugin based on neovim built-in lsp with highly a performant UI
  "folke/lsp-colors.nvim",                              -- automatically creates LSP diagnostics highlight groups for color schemes that don't support builtin lsp
  "hrsh7th/cmp-nvim-lsp",                               -- completion frontend using only native nvim lsp features
  "hrsh7th/cmp-buffer",                                 -- completion frontend using only native nvim lsp features
  "hrsh7th/cmp-path",                                   -- completion frontend using only native nvim lsp features
  "hrsh7th/cmp-cmdline",                                -- completion frontend using only native nvim lsp features
  "hrsh7th/nvim-cmp",                                   -- completion frontend using only native nvim lsp features
  {"L3MON4D3/LuaSnip", build = "make install_jsregexp"}, -- completion frontend using only native nvim lsp features
  "saadparwaiz1/cmp_luasnip",                           -- completion frontend using only native nvim lsp features
  "onsails/lspkind-nvim",                               -- vscode-like pictograms for neovim lsp completion items
  -- {"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  --   config = function()
  --     require("lsp_lines").setup()
  --   end,
  -- },
  {"puremourning/vimspector",                            -- VSCode style debugging
   build='~/.local/share/nvim/lazy/vimspector/install_gadget.py --all',
  },
  {"nvim-treesitter/nvim-treesitter", cmd="TSUpdate"}, -- treesitter all in one language syntax
  "nvim-treesitter/nvim-treesitter-textobjects",        -- use treesitter for smart text objects
--  "p00f/nvim-ts-rainbow",                               -- use treesitter for rainbow params
  {"prettier/vim-prettier",
    build="yarn install --frozen-lockfile --production",
    branch="release/0.x"
  },
  {"nvim-telescope/telescope.nvim", tag = '0.1.8',
   dependencies = {"nvim-lua/plenary.nvim"}
  },
  {"nvim-telescope/telescope-fzf-native.nvim",
   build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
  },
  {"pianocomposer321/yabs.nvim",
   dependencies = { "nvim-lua/plenary.nvim" }
  },
  "ojroques/nvim-lspfuzzy",                             -- use skim for quickfix list
  "hoob3rt/lualine.nvim",                               -- statusline in lua
  {"akinsho/bufferline.nvim",
--    tag = "v2.*",
    dependencies = "kyazdani42/nvim-web-devicons"
  },
  "justinmk/vim-dirvish",                               -- replacement for netrw
  "kristijanhusak/vim-dirvish-git",                     -- add git bloat to dirvish
  "bounceme/remote-viewer",                             -- add remote fs support to dirvish; now it's really netrw
  "tpope/vim-eunuch",                                   -- Unix commands in vim; useful for dirvish
  "jamessan/vim-gnupg",                                 -- easy encripted files in vim
  "neanias/everforest-nvim",
  "sainnhe/everforest",                                 -- colorscheme that plays nice with redshift
  "glepnir/dashboard-nvim",                             -- pretty starting bloat for vim
  "neomutt/neomutt.vim",                                -- helpful setting for mail ft
  "easymotion/vim-easymotion",                          -- visualize text motions
  "tpope/vim-commentary",                               -- easy comments in vim style
  "tpope/vim-surround",                                 -- change surrounding grouping symbol
  "tpope/vim-repeat",                                   -- repeat full plugin actions
  "rhysd/vim-grammarous",                               -- all in one grammar checker for vim
  "mbbill/undotree",                                    -- undo visualizer for vim
  "dhruvasagar/vim-table-mode",                         -- make table structures right in vim
  { "RRethy/vim-hexokinase", build="make hexokinase" },
  "elkowar/yuck.vim",
  "ntpeters/vim-better-whitespace",
--  { "dccsillag/magma-nvim", cmd = "UpdateRemotePlugins" }, -- visualizer for python
})
