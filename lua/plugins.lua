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
        }, -- Git related plugins
        {
            'tpope/vim-fugitive',
            config = function() require("setups.fugitive").setup() end
        }, 'tpope/vim-rhubarb', 'lewis6991/gitsigns.nvim',       -- Themes
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
        {
            "startup-nvim/startup.nvim",
            dependencies = {
                "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"
            },
            config = function() require "startup".setup() end
        }, {
        "ThePrimeagen/harpoon",
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
        'nvim-tree/nvim-tree.lua',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function() require("setups.nvimtree").setup() end
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
        'simrat39/rust-tools.nvim',
        config = function() require("setups.rusttools").setup() end
    }, {
        'norcalli/nvim-colorizer.lua',
        config = function() require 'colorizer'.setup() end
    }, { 'ThePrimeagen/vim-be-good' }, { 'stevearc/conform.nvim', opts = {} },
        {
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
            openai = {
                endpoint = "https://api.openai.com/v1",
                model = "gpt-4o",
                timeout = 30000,
                temperature = 0,
                max_tokens = 4096
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
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            bigfile = { enabled = true },
            dashboard = { enabled = true },
            explorer = { enabled = true },
            indent = { enabled = true },
            input = { enabled = true },
            picker = { enabled = true },
            notifier = { enabled = true },
            quickfile = { enabled = true },
            scope = { enabled = true },
            scroll = { enabled = true },
            statuscolumn = { enabled = true },
            words = { enabled = true },
        },
    }

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
end

return M
