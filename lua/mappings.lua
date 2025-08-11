local keymap = vim.keymap
local M = {}

function M.setup()
    -- Keymaps for better default experience
    -- See `:help vim.keymap.set()`
    keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

    -- Remap for dealing with word wrap
    keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'",
        { expr = true, silent = true })
    keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'",
        { expr = true, silent = true })

    -- Personal Keymaps
    -- keymap.set('n', ';', ':', { silent = true })
    keymap.set({ 'n', 'v' }, '<leader>4', '$', { silent = true })
    keymap.set({ 'n', 'v' }, '<leader>3', '#', { silent = true })
    keymap.set({ 'n', 'v' }, '<leader>5', '%', { silent = true })
    keymap.set({ 'n', 'v' }, '<leader>6', '^', { silent = true })
    keymap.set({ 'n', 'v' }, '<leader>7', '&', { silent = true })
    keymap.set({ 'n', 'v' }, '<leader>8', '*', { silent = true })
    keymap.set({ 'n', 'v' }, '<leader>[', '<C-o>', { silent = true })
    keymap.set({ 'n', 'v' }, '<leader>]', '<C-i>', { silent = true })
    keymap.set({ 'n', 'v' }, '<leader>w', '<C-w>', { silent = true })
    keymap.set({ 'n', 'v' }, '<leader>f', ':Format<CR>', { silent = true })
    keymap.set({ 'n', 'v' }, '<leader>b',
        "<cmd>lua require('commands').BuildCommand()<cr>",
        { silent = false })
    keymap.set({ 'n', 'v' }, '<leader><F5>',
        "<cmd>lua require('commands').LaunchCommand()<cr>",
        { silent = false })
    keymap.set({ 'n', 'v' }, '<F6>',
        "<cmd>lua require('commands').TestCommand()<cr>",
        { silent = false })
    keymap.set({ 'n', 'v' }, '<leader>cc',
        "<cmd>lua require('filetypes.cpp').switchHeaderFile()<cr>",
        { silent = false })

    -- keymap.set('n', '<leader>K', 'oTODO:<esc>VgcA', { silent = true, noremap=true })
    keymap.set('n', '<leader>K', '', { silent = true, noremap = true })

    keymap.set('n', '<F12>', ':source $MYVIMRC<CR>', { silent = true })

    -- Diagnostic keymaps
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
    vim.keymap.set('n', 'do', vim.diagnostic.open_float)
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

    -- vim.keymap.set('n', '<leader>bn', vim.diagnostic.open_float, "Open Diagnostics")
    -- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist,  "Open Diagnostics")

    -- local Terminal = require("snacks.terminal").Terminal

    -- local cargo_build_term = Terminal:new({
    --     cmd = "cargo build",
    --     direction = "vertical", -- or "float", "horizontal", etc.
    --     close_on_exit = true,
    --     on_exit = function(term, exit_code)
    --         if exit_code == 0 then
    --             term:close()
    --         end
    --     end,
    -- })

    vim.keymap.set("n", "<leader>l", function()
        cargo_build_term:toggle()
    end, { noremap = true, silent = true })
end

return M
