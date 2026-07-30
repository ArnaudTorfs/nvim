--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.termguicolors = true

require("plugins").setup()
require("options").setup()
require("mappings").setup()

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight',
  { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.highlight.on_yank() end,
  group = highlight_group,
  pattern = '*'
})

-- Processing sketch support
function RunProcessingSketch()
  local current_file = vim.fn.expand('%:p')
  local sketch_dir = vim.fn.expand('%:p:h')
  vim.cmd('!processing-java --sketch=' .. sketch_dir .. ' --run')
end

vim.api.nvim_set_keymap('n', '<leader>rp', ':lua RunProcessingSketch()<CR>',
  { noremap = true, silent = true })
vim.filetype.add({ extension = { pde = "Java" } })

-- My plugins
require("myplugin").attach_to_log_files()
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

if vim.loop.os_uname().sysname == "Windows_NT" then
  vim.opt.shell = "powershell.exe"
  vim.opt.shellcmdflag =
  "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
  vim.opt.shellquote = "\""
  vim.opt.shellxquote = ""
end

-- Exit terminal mode with ESC
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })
