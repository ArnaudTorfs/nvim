local M = {}

function M.setup()
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
        -- bootstrap lazy.nvim
        -- stylua: ignore
        vim.fn.system({
            "git", "clone", "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git", "--branch=stable",
            lazypath
        })
    end

    vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

    require('lazy').setup({
        { -- LSP Configuration & Plugins
            'neovim/nvim-lspconfig',
            dependencies = {
                -- Automatically install LSPs to stdpath for neovim
                'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim',
                "mfussenegger/nvim-lint", "rshkarin/mason-nvim-lint",

                -- Useful status updates for LSP
                'j-hui/fidget.nvim',

                -- Additional lua configuration, makes nvim stuff amazing
                'folke/neodev.nvim'
            }
        }, { -- Autocompletion
            'hrsh7th/nvim-cmp',
            dependencies = {
                'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip',
                'saadparwaiz1/cmp_luasnip'
            }
        }, { -- Highlight, edit, and navigate code
            'nvim-treesitter/nvim-treesitter',
            build = function()
                pcall(require('nvim-treesitter.install').update {
                    with_sync = true
                })
            end,
            dependencies = {'nvim-treesitter/nvim-treesitter-textobjects'}
        }, -- Git related plugins
        {
            'tpope/vim-fugitive',
            config = function() require("setups.fugitive").setup() end
        }, 'tpope/vim-rhubarb', 'lewis6991/gitsigns.nvim',

        "ellisonleao/gruvbox.nvim", "folke/tokyonight.nvim",
        'nvim-lualine/lualine.nvim',
        {'lukas-reineke/indent-blankline.nvim', main = 'ibl'},

        'numToStr/Comment.nvim', 'tpope/vim-sleuth',

        -- Fuzzy Finder (files, lsp, etc)
        {
            'nvim-telescope/telescope.nvim',
            branch = '0.1.x',
            dependencies = {'nvim-lua/plenary.nvim'}
        },

        -- Fuzzy Finder Algorithm which dependencies local dependencies to be built. Only load if `make` is available
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            cond = vim.fn.executable 'make' == 1
        }, -- logfiles related:
        'mtdl9/vim-log-highlighting', {
            "Pocco81/auto-save.nvim",
            config = function()
                require("auto-save").setup {
                    -- your config goes here
                    -- or just leave it empty :)
                }
            end
        }, {
            "kylechui/nvim-surround",
            version = "*", -- Use for stability; omit to use `main` branch for the latest features
            event = "VeryLazy",
            config = function()
                require("nvim-surround").setup({
                    -- Configuration here, or leave empty to use defaults
                })
            end
        }, {
            "folke/which-key.nvim",
            config = function()
                vim.o.timeout = true
                vim.o.timeoutlen = 300
                -- require("which-key").setup {
                --
                -- }
            end
        }, -- Debugging
        {
            "mfussenegger/nvim-dap",
            lazy = true,
            event = "BufReadPre",
            module = {"dap"},
            dependencies = {
                "nvim-dap-virtual-text", "DAPInstall.nvim", "nvim-dap-ui",
                "nvim-dap-python", "which-key.nvim", "Pocco81/DAPInstall.nvim",
                "theHamsta/nvim-dap-virtual-text", "rcarriga/nvim-dap-ui",
                "mfussenegger/nvim-dap-python",
                "nvim-telescope/telescope-dap.nvim",
                {"leoluz/nvim-dap-go", module = "dap-go"},
                {"jbyuki/one-small-step-for-vimkind", module = "osv"}
            },
            config = function() require("setups.dap").setup() end
        }, 'duane9/nvim-rg', -- project config
        {
            'windwp/nvim-projectconfig',
            config = function()
                require('nvim-projectconfig').setup({
                    project_dir = vim.fn.getcwd()
                })
            end
        }, {
            "L3MON4D3/LuaSnip",
            version = "v2.*",
            build = "make install_jsregexp",
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
                require("luasnip.loaders.from_lua").load({
                    paths = {"~/.config/nvim/lua/snippets/"}
                })
            end
        }, -- startup
        {
            "startup-nvim/startup.nvim",
            dependencies = {
                "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"
            },
            config = function() require"startup".setup() end
        }, {
            "ThePrimeagen/harpoon",
            dependencies = {"nvim-lua/plenary.nvim"},
            config = function() require("setups.harpoon").setup() end
        }, -- {
        -- 	"epwalsh/obsidian.nvim",
        -- 	config = function()
        -- 		require("setups.obsidian").setup()
        -- 	end
        -- },
        {
            'akinsho/flutter-tools.nvim',
            dependencies = {
                'nvim-lua/plenary.nvim', 'stevearc/dressing.nvim' -- optional for vim.ui.select
            },
            config = function()
                require("flutter-tools").setup {} -- use defaults
            end
        }, {
            "justinmk/vim-sneak",
            config = function() require("setups.sneak").setup() end
        }, {
            'nvim-tree/nvim-tree.lua',
            dependencies = {
                'nvim-tree/nvim-web-devicons' -- optional
            },
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
        }, {'ThePrimeagen/vim-be-good'}, {'stevearc/conform.nvim', opts = {}}
    })

    require("setups.comment")
    require("setups.gitsigns")
    require("setups.lsp")
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
