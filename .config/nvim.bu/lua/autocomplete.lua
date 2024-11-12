local opt = vim.opt -- set options
local map = vim.api.nvim_set_keymap

opt.winblend = 8    -- sudo transparency floating windows
opt.pumblend = 8    -- sudo transparency fo pop up menus

opt.completeopt = { 'menuone', 'noinsert', 'noselect' }    --show menu but dont insert/select; breaks flow
opt.wildoptions = 'pum'                                    -- show wild options in pop-up menu
opt.wildmode    = { 'longest:full', 'full' }
opt.wildmenu    = true  -- enable addvnaced tab completion
-- ignore these
opt.wildignore  = [[
.git,.hg,.svn                                                    -- version control
*.aux,*.out,*.toc                                                -- latex intermediate files
*.rej,*.so'                                                      -- patterns to ignore during file-navigation
*.o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class                   -- compiled object files
*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp           -- binary images
*.avi,*.divx,*.mp4,*.webm,*.mov,*.m2ts,*.mkv,*.vob,*.mpg,*.mpeg  -- binary video
*.mp3,*.oga,*.ogg,*.wav,*.flac                                   -- binary audio
*.eot,*.otf,*.ttf,*.woff                                         --
*.doc,*.pdf,*.cbr,*.cbz                                          -- binary documents
*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.kgb                    -- compressed files
*.swp,.lock,.DS_Store,._*                                        --
*.spl                                                            -- compiled spelling files
*.sw?                                                            -- vim swap files
*.luac,*.pyc                                                     -- bytecode
migrations                                                       --django migrations
*.orig                                                           -- merge resolution
classes,lib                                                      -- Clojure/Leiningen
]]

opt.shortmess = opt.shortmess + 'A' -- ignore annoying swapfile messages
opt.shortmess = opt.shortmess + 'I' -- no splash screen
opt.shortmess = opt.shortmess + 'O' -- file-read message overwrites previous
opt.shortmess = opt.shortmess + 'T' -- truncate non-file messages in middle
opt.shortmess = opt.shortmess + 'W' -- don't echo "[w]"/"[written]" when writing
opt.shortmess = opt.shortmess + 'a' -- use abbreviations in messages eg. `[RO]` instead of `[readonly]`
opt.shortmess = opt.shortmess + 'c' -- completion messages
opt.shortmess = opt.shortmess + 'o' -- overwrite file-written messages
opt.shortmess = opt.shortmess + 't' -- truncate file messages at start

-- Use <Tab> and <S-Tab> to navigate through popup menu
map('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<Tab>"]], {expr = true})
map('i', '<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]], {expr = true})
