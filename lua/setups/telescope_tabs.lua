require('telescope').load_extension('telescope-tabs')
require('telescope-tabs').setup {
    -- Your custom config :^)
}

vim.keymap.set('n', '<leader>t', ':Telescope telescope-tabs list_tabs<CR>', { noremap = true, silent = true })
