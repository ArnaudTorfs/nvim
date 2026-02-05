local lspconfig = require("lspconfig")

-- require 'lspconfig'.lua_ls.setup {
--     settings = {
--         Lua = {
--             diagnostics = {
--                 -- Get the language server to recognize the `vim` global
--                 globals = { 'vim' }
--             }
--         }
--     }
-- }
lspconfig.angularls.setup {}

lspconfig.clangd.setup {}

local util = require("lspconfig.util")

-- lspconfig.ts_ls.setup({
--   single_file_support = false,
--   root_dir = function(fname)
--     -- If angular.json exists → disable ts_ls
--     if util.root_pattern("angular.json")(fname) then
--       return nil
--     end
--     return util.root_pattern("package.json", "tsconfig.json", ".git")(fname)
--   end,
-- })

lspconfig.angularls.setup({
  filetypes = {
    "html",
    "htmlangular",
  },
})
