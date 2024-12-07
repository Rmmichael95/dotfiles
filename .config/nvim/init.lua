-- Maintainer: Ryan M Sullivan
-- Last Change: August 10, 2021
-- ------------------------------------------------------------------------------
-- Vim Configuration
-- ------------------------------------------------------------------------ " {{{1

require("config.core")
require("config.lazy")

-- has to be after plugins to work. debugging
vim.api.nvim_set_keymap("n", ";", ":", { noremap = true })
