vim.lsp.config('angularls', {
  filetypes = { "html", "htmlangular" },
})

vim.lsp.enable('angularls')
vim.lsp.enable('clangd')

-- lsp/csharp_ls.lua uses a lspconfig-specific cmd(dispatchers, config) signature
-- that nvim's native API doesn't support. Override cmd with a plain array.
vim.lsp.config('csharp_ls', {
  cmd = { 'csharp-ls' },
})

-- vim.lsp.config('ts_ls', {
--   root_dir = function(bufnr, on_dir)
--     local fname = vim.api.nvim_buf_get_name(bufnr)
--     local util = require("lspconfig.util")
--     if util.root_pattern("angular.json")(fname) then return on_dir(nil) end
--     on_dir(util.root_pattern("package.json", "tsconfig.json", ".git")(fname))
--   end,
-- })
