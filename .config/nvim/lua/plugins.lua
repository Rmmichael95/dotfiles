local cmd = vim.cmd -- vim command

cmd([[
if empty(glob('~/.local/share/nvim/site'))
    silent !git clone --depth=1 https://github.com/savq/paq-nvim.git \
          "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/paqs/start/paq-nvim
endif
]])

require "paq" {
    "savq/paq-nvim";                                      -- Let Paq manage itself
    "neovim/nvim-lspconfig";                              -- config for nvim build in lsp
    "glepnir/lspsaga.nvim";                               -- A light-weight lsp plugin based on neovim built-in lsp with highly a performant UI
    "folke/lsp-colors.nvim";                              -- automatically creates LSP diagnostics highlight groups for color schemes that don't support builtin lsp
    "hrsh7th/cmp-nvim-lsp";                               -- completion frontend using only native nvim lsp features
    "hrsh7th/cmp-buffer";                                 -- completion frontend using only native nvim lsp features
    "hrsh7th/cmp-path";                                   -- completion frontend using only native nvim lsp features
    "hrsh7th/cmp-cmdline";                                -- completion frontend using only native nvim lsp features
    "hrsh7th/nvim-cmp";                                   -- completion frontend using only native nvim lsp features
    "L3MON4D3/LuaSnip";                                   -- completion frontend using only native nvim lsp features
    "saadparwaiz1/cmp_luasnip";                           -- completion frontend using only native nvim lsp features
    "onsails/lspkind-nvim";                               -- vscode-like pictograms for neovim lsp completion items
    {"nvim-treesitter/nvim-treesitter", run=":TSUpdate"}; -- treesitter all in one language syntax
    "nvim-treesitter/nvim-treesitter-textobjects";        -- use treesitter for smart text objects
    "p00f/nvim-ts-rainbow";                               -- use treesitter for rainbow params
    {"prettier/vim-prettier",
        run="~/.local/share/nvim/site/pack/paqs/start/vim-prettier/yarn install"
    };                                                    -- use prettier in nvim
    {"puremourning/vimspector",
        run="~/.local/share/nvim/site/pack/paqs/start/vimspector/python3 install_gadget.py --all"
    };                                                    -- VSCode style debugging
    {"lotabout/skim",
        as="~/.local/share/skim",
        run="~/.local/share/skim/install"
    };                                                    -- local file
    "lotabout/skim.vim";                                  -- drop in replacement for fzf in rust
    "ojroques/nvim-lspfuzzy";                             -- use skim for quickfix list
    "pianocomposer321/yabs.nvim";                         -- easy builds in vim
    "hoob3rt/lualine.nvim";                               -- statusline in lua
    "kyazdani42/nvim-web-devicons";                       -- icon bloat for lualine
    "justinmk/vim-dirvish";                               -- replacement for netrw
    "kristijanhusak/vim-dirvish-git";                     -- add git bloat to dirvish
    "bounceme/remote-viewer";                             -- add remote fs support to dirvish; now it's really netrw
    "tpope/vim-eunuch";                                   -- Unix commands in vim; useful for dirvish
    "jamessan/vim-gnupg";                                 -- easy encripted files in vim
    "sainnhe/everforest";                                 -- colorscheme that plays nice with redshift
    "glepnir/dashboard-nvim";                             -- pretty starting bloat for vim
    "neomutt/neomutt.vim";                                -- helpful setting for mail ft
    "easymotion/vim-easymotion";                          -- visualize text motions
    "tpope/vim-commentary";                               -- easy comments in vim style
    "tpope/vim-endwise";                                  -- help end some programing structures
    "tpope/vim-surround";                                 -- change surrounding grouping symbol
    "tpope/vim-repeat";                                   -- repeat full plugin actions
    "jiangmiao/auto-pairs";                               -- suto complete paired structures
    "rhysd/vim-grammarous";                               -- all in one grammar checker for vim
    "mbbill/undotree";                                    -- undo visualizer for vim
    "preservim/tagbar";                                   -- visualize ctags in vim
    "jsfaint/gen_tags.vim";                               -- easy gtags/ctags
    "dhruvasagar/vim-table-mode";                         -- make table structures right in vim
}
