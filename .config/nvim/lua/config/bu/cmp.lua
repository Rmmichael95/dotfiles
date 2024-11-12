local cmp = require'cmp'
local opt = vim.opt -- set options
local lspkind = require'lspkind'

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true
    }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'luasnip' },
    { name = 'path' },
  }),
  formatting = {
    format = lspkind.cmp_format({
        mode = 'symbol',
        with_text = false,
        maxwidth = 50})
  }
    -- The function below will be called before any actual modifications from lspkind
    -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
})

vim.cmd [[highlight! default link CmpItemKind CmpItemMenuDefault]]

opt.winblend = 8    -- sudo transparency floating windows
opt.pumblend = 8    -- sudo transparency fo pop up menus

opt.completeopt = { "menuone", "noinsert", "noselect" }    --show menu but dont insert/select; breaks flow
opt.wildoptions = 'pum'                                    -- show wild options in pop-up menu
opt.wildmode    = { "longest:full", "full" }
opt.wildmenu    = true  -- enable addvnaced tab completion
-- ignore these
-- version control
-- latex intermediate files
-- patterns to ignore during file-navigation
-- compiled object files
-- binary images
-- binary video
-- binary audio
-- --
-- binary documents
-- compressed files
--
-- compiled spelling files
-- vim swap files
-- bytecode
-- django migrations
-- merge resolution
-- Clojure/Leiningen
opt.wildignore  = [[
.git,.hg,.svn
*.aux,*.out,*.toc,
*.rej,*.so',
*.o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class,
*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp,
*.avi,*.divx,*.mp4,*.webm,*.mov,*.m2ts,*.mkv,*.vob,*.mpg,*.mpeg,
*.mp3,*.oga,*.ogg,*.wav,*.flac,
*.eot,*.otf,*.ttf,*.woff,
*.doc,*.pdf,*.cbr,*.cbz,
*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.kgb,
*.swp,.lock,.DS_Store,._*,
*.spl,
*.sw?,
*.luac,*.pyc,
migrations,
*.orig,
classes,lib
]]
