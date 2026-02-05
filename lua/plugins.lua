local M = {}

function M.setup()
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
        -- Bootstrap lazy.nvim
        vim.fn.system({
            "git", "clone", "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git", "--branch=stable",
            lazypath
        })
    end

    vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

    require('lazy').setup({
        -- LSP Configuration & Plugins
        {
            'neovim/nvim-lspconfig',
            dependencies = {
                'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim',
                "mfussenegger/nvim-lint", "rshkarin/mason-nvim-lint",
                'j-hui/fidget.nvim', 'folke/neodev.nvim'
            }
        }, -- Autocompletion
        {
            'hrsh7th/nvim-cmp',
            dependencies = {
                'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip',
                'saadparwaiz1/cmp_luasnip'
            }
        }, -- Highlight, edit, and navigate code
        {
            'nvim-treesitter/nvim-treesitter',
            build = function()
                pcall(require('nvim-treesitter.install').update {
                    with_sync = true
                })
            end,
            dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' }
        },
        'tpope/vim-rhubarb', 'lewis6991/gitsigns.nvim',          -- Themes
        "ellisonleao/gruvbox.nvim", "folke/tokyonight.nvim",     -- Status line
        'nvim-lualine/lualine.nvim',                             -- Indentation guides
        { 'lukas-reineke/indent-blankline.nvim', main = 'ibl' }, -- Commenting
        'numToStr/Comment.nvim',                                 -- Detect tabstop and shiftwidth automatically
        'tpope/vim-sleuth',                                      -- Fuzzy Finder
        {
            'nvim-telescope/telescope.nvim',
            branch = '0.1.x',
            dependencies = { 'nvim-lua/plenary.nvim' }
        }, -- Fuzzy Finder Algorithm
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            cond = vim.fn.executable 'make' == 1
        }, -- Logfiles related
        'mtdl9/vim-log-highlighting', {
        "Pocco81/auto-save.nvim",
        config = function() require("auto-save").setup {} end
    }, {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function() require("nvim-surround").setup({}) end
    }, {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end
    }, -- Debugging
        {
            "mfussenegger/nvim-dap",
            lazy = true,
            event = "BufReadPre",
            module = { "dap" },
            dependencies = {
                "nvim-dap-virtual-text", "DAPInstall.nvim", "nvim-dap-ui",
                "nvim-dap-python", "which-key.nvim", "Pocco81/DAPInstall.nvim",
                "theHamsta/nvim-dap-virtual-text", "rcarriga/nvim-dap-ui",
                "mfussenegger/nvim-dap-python",
                "nvim-telescope/telescope-dap.nvim",
                { "leoluz/nvim-dap-go",                module = "dap-go" },
                { "jbyuki/one-small-step-for-vimkind", module = "osv" }
            },
            config = function() require("setups.dap").setup() end
        }, 'duane9/nvim-rg', -- Project config
        {
            'windwp/nvim-projectconfig',
            config = function()
                require('nvim-projectconfig').setup({
                    project_dir = vim.fn.getcwd()
                })
            end
        }, {
        "Cliffback/netcoredbg-macOS-arm64.nvim",
        dependencies = { "mfussenegger/nvim-dap" },
        config = function()
            require('netcoredbg-macOS-arm64').setup(require('dap'))
        end
    }, {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip.loaders.from_lua").load({
                paths = { "~/.config/nvim/lua/snippets/" }
            })
        end
    }, -- Startup
        -- {
        --     "startup-nvim/startup.nvim",
        --     dependencies = {
        --         "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"
        --     },
        --     config = function() require "startup".setup() end
        -- },
        {
            "ThePrimeagen/harpoon",
            branch = "harpoon2",
            dependencies = { "nvim-lua/plenary.nvim" },
            config = function() require("setups.harpoon").setup() end
        }, {
        'akinsho/flutter-tools.nvim',
        dependencies = { 'nvim-lua/plenary.nvim', 'stevearc/dressing.nvim' },
        config = function() require("flutter-tools").setup {} end
    }, {
        "justinmk/vim-sneak",
        config = function() require("setups.sneak").setup() end
    }, {
        "nvim-neotest/neotest",
        lazy = false,
        dependencies = {
            "nvim-neotest/nvim-nio", "vim-test/vim-test",
            "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-neotest/neotest-python", "nvim-neotest/neotest-plenary",
            "nvim-neotest/neotest-vim-test", "rouge8/neotest-rust",
            'stevearc/overseer.nvim', "plenary.nvim", "nvim-treesitter",
            "FixCursorHold.nvim", "neotest-python", "neotest-plenary",
            "neotest-vim-test", "neotest-rust", "vim-test", "overseer.nvim",
            "nvim-neotest/neotest-go", "Issafalcon/neotest-dotnet"
        },
        cmd = {
            "TestNearest", "TestFile", "TestSuite", "TestLast", "TestVisit"
        },
        config = function() require("setups.neotest").setup() end,
        enabled = true
    }, {
        'mrcjkb/rustaceanvim',
        version = '^5',
        lazy = false, -- This plugin is already lazy
        ft = { 'rust' },
    }, {
        'norcalli/nvim-colorizer.lua',
        config = function() require 'colorizer'.setup() end
    }, {
        'ThePrimeagen/vim-be-good'
    }, {

        'stevearc/conform.nvim',
        opts = {}
    }, {
        'barrett-ruth/live-server.nvim',
        build = 'pnpm add -g live-server',
        cmd = { 'LiveServerStart', 'LiveServerStop' },
        config = true
    }, {
        "yetone/avante.nvim",
        event = "VeryLazy",
        lazy = false,
        version = false,
        opts = {
            provider = "openai",
            providers = {
                openai = {
                    endpoint = "https://api.openai.com/v1",
                    model = "gpt-5",
                    timeout = 30000,
                    extra_request_body = {
                        temperature = 1,
                        max_completion_tokens = 13192, -- Increase this to include reasoning tokens (for reasoning models)
                        reasoning_effort = "high",
                    },
                    max_tokens = 13096
                }
            }
        },
        build = "make",
        dependencies = {
            "stevearc/dressing.nvim", "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim", "echasnovski/mini.pick",
            "nvim-telescope/telescope.nvim", "hrsh7th/nvim-cmp",
            "ibhagwan/fzf-lua", "nvim-tree/nvim-web-devicons",
            "zbirenbaum/copilot.lua", {
            "HakonHarnes/img-clip.nvim",
            event = "VeryLazy",
            opts = {
                default = {
                    embed_image_as_base64 = false,
                    prompt_for_file_name = false,
                    drag_and_drop = { insert_mode = true },
                    use_absolute_path = true
                }
            }
        }, {
            'MeanderingProgrammer/render-markdown.nvim',
            opts = { file_types = { "markdown", "Avante" } },
            ft = { "markdown", "Avante" }
        }
        }
    }, {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            bigfile = { enabled = true },
            dashboard = {
                enabled = true,
                sections = {
                    { section = "header" },
                    -- { section = "harpoon", title = "Harpoon", icon = " " },
                    { section = "startup" },
                },
            },
            explorer = { enabled = true },
            indent = { enabled = true },
            input = { enabled = true },
            notifier = {
                enabled = true,
                timeout = 3000,
            },
            picker = { enabled = true },
            quickfile = { enabled = true },
            scope = { enabled = true },
            -- scroll = { enabled = true },
            statuscolumn = { enabled = true },
            words = { enabled = true },
            styles = {
                notification = {
                    -- wo = { wrap = true } -- Wrap notifications
                }
            }
        },
        keys = {
            -- Top Pickers & Explorer
            { "<leader><space>", function() Snacks.picker.smart() end,                                   desc = "Smart Find Files" },
            { "<leader>,",       function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
            { "<leader>/",       function() Snacks.picker.grep() end,                                    desc = "Grep" },
            { "<leader>:",       function() Snacks.picker.command_history() end,                         desc = "Command History" },
            -- { "<leader>n",       function() Snacks.picker.notifications() end,                           desc = "Notification History" },
            { "<leader>e",       function() Snacks.explorer() end,                                       desc = "File Explorer" },
            -- find
            { "<leader>fb",      function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
            { "<leader>fc",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
            { "<leader>ff",      function() Snacks.picker.files() end,                                   desc = "Find Files" },
            { "<leader>fg",      function() Snacks.picker.git_files() end,                               desc = "Find Git Files" },
            { "<leader>fp",      function() Snacks.picker.projects() end,                                desc = "Projects" },
            { "<leader>fr",      function() Snacks.picker.recent() end,                                  desc = "Recent" },
            -- git
            { "<leader>gb",      function() Snacks.picker.git_branches() end,                            desc = "Git Branches" },
            { "<leader>gl",      function() Snacks.picker.git_log() end,                                 desc = "Git Log" },
            { "<leader>gL",      function() Snacks.picker.git_log_line() end,                            desc = "Git Log Line" },
            { "<leader>gs",      function() Snacks.picker.git_status() end,                              desc = "Git Status" },
            { "<leader>gS",      function() Snacks.picker.git_stash() end,                               desc = "Git Stash" },
            { "<leader>gd",      function() Snacks.picker.git_diff() end,                                desc = "Git Diff (Hunks)" },
            { "<leader>gf",      function() Snacks.picker.git_log_file() end,                            desc = "Git Log File" },
            -- Grep
            { "<leader>sb",      function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
            { "<leader>sB",      function() Snacks.picker.grep_buffers() end,                            desc = "Grep Open Buffers" },
            { "<leader>sg",      function() Snacks.picker.grep() end,                                    desc = "Grep" },
            { "<leader>sw",      function() Snacks.picker.grep_word() end,                               desc = "Visual selection or word", mode = { "n", "x" } },
            -- search
            { '<leader>s"',      function() Snacks.picker.registers() end,                               desc = "Registers" },
            { '<leader>s/',      function() Snacks.picker.search_history() end,                          desc = "Search History" },
            { "<leader>sa",      function() Snacks.picker.autocmds() end,                                desc = "Autocmds" },
            { "<leader>sb",      function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
            { "<leader>sc",      function() Snacks.picker.command_history() end,                         desc = "Command History" },
            { "<leader>sC",      function() Snacks.picker.commands() end,                                desc = "Commands" },
            { "<leader>sd",      function() Snacks.picker.diagnostics() end,                             desc = "Diagnostics" },
            { "<leader>sD",      function() Snacks.picker.diagnostics_buffer() end,                      desc = "Buffer Diagnostics" },
            { "<leader>sh",      function() Snacks.picker.help() end,                                    desc = "Help Pages" },
            { "<leader>sH",      function() Snacks.picker.highlights() end,                              desc = "Highlights" },
            { "<leader>si",      function() Snacks.picker.icons() end,                                   desc = "Icons" },
            { "<leader>sj",      function() Snacks.picker.jumps() end,                                   desc = "Jumps" },
            { "<leader>sk",      function() Snacks.picker.keymaps() end,                                 desc = "Keymaps" },
            { "<leader>sl",      function() Snacks.picker.loclist() end,                                 desc = "Location List" },
            { "<leader>sm",      function() Snacks.picker.marks() end,                                   desc = "Marks" },
            { "<leader>sM",      function() Snacks.picker.man() end,                                     desc = "Man Pages" },
            { "<leader>sp",      function() Snacks.picker.lazy() end,                                    desc = "Search for Plugin Spec" },
            { "<leader>sq",      function() Snacks.picker.qflist() end,                                  desc = "Quickfix List" },
            { "<leader>sR",      function() Snacks.picker.resume() end,                                  desc = "Resume" },
            { "<leader>su",      function() Snacks.picker.undo() end,                                    desc = "Undo History" },
            { "<leader>uC",      function() Snacks.picker.colorschemes() end,                            desc = "Colorschemes" },
            -- LSP
            { "gd",              function() Snacks.picker.lsp_definitions() end,                         desc = "Goto Definition" },
            { "gD",              function() Snacks.picker.lsp_declarations() end,                        desc = "Goto Declaration" },
            { "gr",              function() Snacks.picker.lsp_references() end,                          nowait = true,                     desc = "References" },
            { "gI",              function() Snacks.picker.lsp_implementations() end,                     desc = "Goto Implementation" },
            { "gy",              function() Snacks.picker.lsp_type_definitions() end,                    desc = "Goto T[y]pe Definition" },
            { "<leader>ss",      function() Snacks.picker.lsp_symbols() end,                             desc = "LSP Symbols" },
            { "<leader>sS",      function() Snacks.picker.lsp_workspace_symbols() end,                   desc = "LSP Workspace Symbols" },
            -- Other
            { "<leader>z",       function() Snacks.zen() end,                                            desc = "Toggle Zen Mode" },
            { "<leader>Z",       function() Snacks.zen.zoom() end,                                       desc = "Toggle Zoom" },
            { "<leader>.",       function() Snacks.scratch() end,                                        desc = "Toggle Scratch Buffer" },
            { "<leader>S",       function() Snacks.scratch.select() end,                                 desc = "Select Scratch Buffer" },
            { "<leader>n",       function() Snacks.notifier.show_history() end,                          desc = "Notification History" },
            { "<leader>bd",      function() Snacks.bufdelete() end,                                      desc = "Delete Buffer" },
            { "<leader>cR",      function() Snacks.rename.rename_file() end,                             desc = "Rename File" },
            { "<leader>gB",      function() Snacks.gitbrowse() end,                                      desc = "Git Browse",               mode = { "n", "v" } },
            { "<leader>gg",      function() Snacks.lazygit() end,                                        desc = "Lazygit" },
            { "<leader>un",      function() Snacks.notifier.hide() end,                                  desc = "Dismiss All Notifications" },
            { "<c-/>",           function() Snacks.terminal() end,                                       desc = "Toggle Terminal" },
            { "<c-_>",           function() Snacks.terminal() end,                                       desc = "which_key_ignore" },
            { "]]",              function() Snacks.words.jump(vim.v.count1) end,                         desc = "Next Reference",           mode = { "n", "t" } },
            { "[[",              function() Snacks.words.jump(-vim.v.count1) end,                        desc = "Prev Reference",           mode = { "n", "t" } },
            {
                "<leader>N",
                desc = "Neovim News",
                function()
                    Snacks.win({
                        file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
                        width = 0.6,
                        height = 0.6,
                        wo = {
                            spell = false,
                            wrap = false,
                            signcolumn = "yes",
                            statuscolumn = " ",
                            conceallevel = 3,
                        },
                    })
                end,
            }
        },
        init = function()
            vim.api.nvim_create_autocmd("User", {
                pattern = "VeryLazy",
                callback = function()
                    -- Setup some globals for debugging (lazy-loaded)
                    _G.dd = function(...)
                        Snacks.debug.inspect(...)
                    end
                    _G.bt = function()
                        Snacks.debug.backtrace()
                    end
                    vim.print = _G.dd -- Override print to use snacks for `:=` command

                    -- Create some toggle mappings
                    Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
                    Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
                    Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
                    Snacks.toggle.diagnostics():map("<leader>ud")
                    Snacks.toggle.line_number():map("<leader>ul")
                    Snacks.toggle.option("conceallevel",
                        { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
                    Snacks.toggle.treesitter():map("<leader>uT")
                    Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map(
                        "<leader>ub")
                    Snacks.toggle.inlay_hints():map("<leader>uh")
                    Snacks.toggle.indent():map("<leader>ug")
                    Snacks.toggle.dim():map("<leader>uD")
                end,
            })
        end,
    }, {
        'akinsho/toggleterm.nvim', version = "*", opts = { --[[ things you want to change go here]] }
    }, {
        'LukasPietzschmann/telescope-tabs',
        dependencies = { 'nvim-telescope/telescope.nvim' },
    }, {
        "letieu/harpoon-lualine",
        dependencies = {
            {
                "ThePrimeagen/harpoon",
                branch = "harpoon2",
            }
        },
    }, 
    --     {
    --     "hachy/cmdpalette.nvim"
    -- },
    })

    require("setups.comment")
    require("setups.gitsigns")
    require("setups.lualine")
    require("setups.treesitter")
    require("setups.mason").setup()
    require("setups.neodev")
    require("setups.telescope")
    require("setups.luasnip")
    require("setups.lspconfig")
    require("mason-nvim-lint").setup()
    require("setups.lint")
    require("setups.conform")
    require("setups.toggleterm")
    require("setups.rustacean")
    require("setups.telescope_tabs")
    -- require("setups.cmdpalette")
end

return M
