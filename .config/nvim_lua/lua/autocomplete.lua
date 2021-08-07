local o = vim.o     -- global options
local wo = vim.wo   -- window options
local opt = vim.opt -- set options
local map = vim.api.nvim_set_keymap

wo.winblend = 5     -- sudo transparency floating windows
wo.pumblend = 10    -- sudo transparency fo pop up menus

o.completeopt = { 'menuone', 'noinsert', 'noselect' } --show menu but dont insert/select; breaks flow
o.wildoptions = 'pum' -- show wild options in pop-up menu
o.wildmode    = { 'longest:full', 'full' }
o.wildmenu    = true  -- enable addvnaced tab completion
-- ignore these
o.wildignore  = [[
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

o.shortmess = o.shortmess .. 'A' -- ignore annoying swapfile messages
o.shortmess = o.shortmess .. 'I' -- no splash screen
o.shortmess = o.shortmess .. 'O' -- file-read message overwrites previous
o.shortmess = o.shortmess .. 'T' -- truncate non-file messages in middle
o.shortmess = o.shortmess .. 'W' -- don't echo "[w]"/"[written]" when writing
o.shortmess = o.shortmess .. 'a' -- use abbreviations in messages eg. `[RO]` instead of `[readonly]`
o.shortmess = o.shortmess .. 'c' -- completion messages
o.shortmess = o.shortmess .. 'o' -- overwrite file-written messages
o.shortmess = o.shortmess .. 't' -- truncate file messages at start

-- Use <Tab> and <S-Tab> to navigate through popup menu
options = { noremap = true }
map('i', '<expr> <Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', options)
map('i', '<expr> <S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', options)
