local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'                             -- Packer can manage itself
  use 'neovim/nvim-lspconfig'                              -- config for nvim build in lsp
  use 'glepnir/lspsaga.nvim'                               -- A light-weight lsp plugin based on neovim built-in lsp with highly a performant UI
  use 'folke/lsp-colors.nvim'                              -- automatically creates LSP diagnostics highlight groups for color schemes that don't support builtin lsp
  use 'hrsh7th/cmp-nvim-lsp'                               -- completion frontend using only native nvim lsp features
  use 'hrsh7th/cmp-buffer'                                 -- completion frontend using only native nvim lsp features
  use 'hrsh7th/cmp-path'                                   -- completion frontend using only native nvim lsp features
  use 'hrsh7th/cmp-cmdline'                                -- completion frontend using only native nvim lsp features
  use 'hrsh7th/nvim-cmp'                                   -- completion frontend using only native nvim lsp features
  use 'L3MON4D3/LuaSnip'                                   -- completion frontend using only native nvim lsp features
  use 'saadparwaiz1/cmp_luasnip'                           -- completion frontend using only native nvim lsp features
  use 'onsails/lspkind-nvim'                               -- vscode-like pictograms for neovim lsp completion items
  use {'nvim-treesitter/nvim-treesitter', run=":TSUpdate"} -- treesitter all in one language syntax
  use 'nvim-treesitter/nvim-treesitter-textobjects'        -- use treesitter for smart text objects
  use 'p00f/nvim-ts-rainbow'                               -- use treesitter for rainbow params
  use {
       'prettier/vim-prettier',
       run='~/.local/share/nvim/site/pack/paqs/start/vim-prettier/yarn install'
    }                                                    -- use prettier in nvim
  use {'puremourning/vimspector',
       run='~/.local/share/nvim/site/pack/paqs/start/vimspector/install_gadget.py --all'
    }                                                    -- VSCode style debugging
  use {
  'nvim-telescope/telescope.nvim', tag = '0.1.0',
       requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  }
  use 'lotabout/skim'
  use 'lotabout/skim.vim'                                -- drop in replacement for fzf in rust
  use({
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
    end,
  })
  use {
    'pianocomposer321/yabs.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  }
  use {'akinsho/bufferline.nvim',
    tag = "v2.*",
    requires = 'kyazdani42/nvim-web-devicons'
  }
  use 'ojroques/nvim-lspfuzzy'                             -- use skim for quickfix list
  use 'hoob3rt/lualine.nvim'                               -- statusline in lua
  use 'kyazdani42/nvim-web-devicons'                       -- icon bloat for lualine
  use 'justinmk/vim-dirvish'                               -- replacement for netrw
  use 'kristijanhusak/vim-dirvish-git'                     -- add git bloat to dirvish
  use 'bounceme/remote-viewer'                             -- add remote fs support to dirvish; now it's really netrw
  use 'tpope/vim-eunuch'                                   -- Unix commands in vim; useful for dirvish
  use 'jamessan/vim-gnupg'                                 -- easy encripted files in vim
  use 'sainnhe/everforest'                                 -- colorscheme that plays nice with redshift
  use 'glepnir/dashboard-nvim'                             -- pretty starting bloat for vim
  use 'neomutt/neomutt.vim'                                -- helpful setting for mail ft
  use 'easymotion/vim-easymotion'                          -- visualize text motions
  use 'tpope/vim-commentary'                               -- easy comments in vim style
  use 'tpope/vim-surround'                                 -- change surrounding grouping symbol
  use 'tpope/vim-repeat'                                   -- repeat full plugin actions
  use 'rhysd/vim-grammarous'                               -- all in one grammar checker for vim
  use 'mbbill/undotree'                                    -- undo visualizer for vim
  use 'dhruvasagar/vim-table-mode'                         -- make table structures right in vim
  use 'RRethy/vim-hexokinase'
  use 'elkowar/yuck.vim'
  use 'ntpeters/vim-better-whitespace'
  use { 'dccsillag/magma-nvim', run = ':UpdateRemotePlugins' } -- visualizer for python

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
