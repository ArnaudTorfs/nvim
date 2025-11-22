local M = {}

function M.setup()
    vim.g.rustaceanvim = {
        server = {
            on_attach = function(client, bufnr)
                -- Hover actions (replaces rt.hover_actions.hover_actions)
                vim.keymap.set("n", "<C-space>", function()
                    vim.cmd.RustLsp({ 'hover', 'actions' })
                end, { buffer = bufnr, desc = "Rust hover actions" })

                -- Code action groups (replaces rt.code_action_group.code_action_group)
                vim.keymap.set("n", "<Leader>a", function()
                    vim.cmd.RustLsp('codeAction')
                end, { buffer = bufnr, desc = "Rust code actions" })
            end,
        },
    }
end

return M
