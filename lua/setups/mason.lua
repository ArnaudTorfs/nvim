local M = {}

function M.setup()
    -- LSP settings.
    -- This function gets run when an LSP connects to a particular buffer.
    local on_attach = function(bufnr)
        -- Helper function to define LSP-related key mappings
        local nmap = function(keys, func, desc)
            if desc then desc = 'LSP: ' .. desc end
            vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        -- Key mappings for LSP functionality
        nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
        nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
        nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
        nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
        nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        -- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
        -- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
        -- nmap('<leader>wl', function()
        --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        -- end, '[W]orkspace [L]ist Folders')

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
            local ft = vim.bo[bufnr].filetype
            if ft == "html" or ft == "htmlangular" then
                -- Use conform.nvim for Angular HTML files
                require("conform").format({
                    bufnr = bufnr,
                    async = true,
                    lsp_fallback = false
                })
            else
                -- Use LSP format for all other files
                vim.lsp.buf.format({ bufnr = bufnr })
            end
        end, { desc = 'Format current buffer' })
    end

    -- Setup mason to manage external tooling
    require('mason').setup({
        ensure_installed = {
            -- Formatters
            "beautysh",
            "black",
            "clang-format",
            "csharpier",
            "gofumpt",
            "goimports",
            "google-java-format",
            "luaformatter",
            "prettierd",
            "rustfmt",
            "sql-formatter",
            "swiftformat",
            "yamlfmt",
        },
    })

    -- Setup mason-lspconfig to ensure servers are installed
    local mason_lspconfig = require('mason-lspconfig')

    vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
            local bufnr = ev.buf
            on_attach(bufnr)
        end,
    })
    mason_lspconfig.setup({
        ensure_installed = {
            "angularls",
            "bashls",
            "clangd",
            "csharp_ls",
            "cssls",
            "cssmodules_ls",
            "emmet_ls",
            "glsl_analyzer",
            "gopls",
            "html",
            "jdtls",
            "jsonls",
            "lua_ls",
            "neocmake",
            "phpactor",
            "pylsp",
            "superhtml",
            "ts_ls",
            "yamlls",
        },
        automatic_installation = true,
        handlers = {
            function(server)
                vim.lsp.enable(server)
            end,

            angularls = function()
                vim.lsp.config('angularls', {
                    filetypes = { "html", "htmlangular" },
                })
                vim.lsp.enable('angularls')
            end,
        }
    })
end

return M
