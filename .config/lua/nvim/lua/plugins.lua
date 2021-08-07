local cmd = vim.cmd -- vim command

--cmd([[
--if empty(glob('~/.cache/dein'))
--    silent !git clone --depth=1 https://github.com/savq/paq-nvim.git
--     \\ "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/paqs/start/paq-nvim
--endif
--]])

require "paq" {
    "savq/paq-nvim";                  -- Let Paq manage itself

    "neovim/nvim-lspconfig";                              -- config for nvim build in lsp
    "nvim-lua/completion-nvim";                           -- completion frontend using only native nvim lsp features
    {"nvim-treesitter/nvim-treesitter", run=":TSUpdate"}; -- treesitter all in one language syntax
    "nvim-treesitter/nvim-treesitter-textobjects";        -- use treesitter for smart text objects
    "nvim-treesitter/nvim-ts-rainbow";                    -- use treesitter for rainbow params
    {"prettier/vim-prettier", run="npm install"};         -- use prettierin nvim
    {"lotabout/skim", as="~/.local/share/skim", run="~/.local/share/skim/install"}; -- local file
    "ojroques/nvim-lspfuzzy"                              -- use skim for quickfix list
    "lotabout/skim.vim";                                  -- drop in replacement for fzf in rust
    "tpope/vim-commentary";                               -- easy comments in vim style
    "hoob3rt/lualine.nvim";                               -- statusline in lua
    "kyazdani42/nvim-web-devicons";                       -- icon bloat for lualine
--    "kyazdani42/nvim-tree.lua";                           -- filetree in lua
    "justinmk/vim-dirvish";                               -- replacement for netrw
    "kristijanhusak/vim-dirvish-git";                     -- add git bloat to firvish
}
