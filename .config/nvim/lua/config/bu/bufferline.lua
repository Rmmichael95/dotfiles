vim.opt.termguicolors = true

local bufferline = require('bufferline')
bufferline.setup {
    options = {
        mode = "tabs", -- set to "tabs" to only show tabpages instead
        separator_style = "slant",
        always_show_bufferline = false,
        close_command = "bdelete! %d",       -- can be a string | function, | false see "Mouse actions"
        right_mouse_command = "bdelete! %d", -- can be a string | function | false, see "Mouse actions"
        left_mouse_command = "buffer %d",    -- can be a string | function, | false see "Mouse actions"
        middle_mouse_command = nil,          -- can be a string | function, | false see "Mouse actions"
        indicator = {
            icon = '▎', -- this should be omitted if indicator style is not 'icon'
            style = 'icon',
        },
        highlights = {
            tab_separator = {
                bg = '#4b565c',
                fg = '#15191c',
            },
        },
        buffer_close_icon = '󰅖',
        modified_icon = '● ',
        close_icon = ' ',
        left_trunc_marker = ' ',
        right_trunc_marker = ' ',
        --- name_formatter can be used to change the buffer's label in the bufferline.
        --- Please note some names can/will break the
        --- bufferline so use this at your discretion knowing that it has
        --- some limitations that will *NOT* be fixed.
    }
}

vim.keymap.set('n', ',t', '<Cmd>BufferLineCycleNext<CR>', {})
vim.keymap.set('n', ',T', '<Cmd>BufferLineCyclePrev<CR>', {})
