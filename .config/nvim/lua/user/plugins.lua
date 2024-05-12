local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
    {
        "catppuccin/nvim",
        as = "catppuccin",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme catppuccin-macchiato]])
        end,
    },
    {
        "nvim-tree/nvim-web-devicons",
        lazy = false,
    },
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("user.nvimtree")
        end,
    },
    {
        "echasnovski/mini.nvim",
        config = function()
            require("user.mini")
        end,
        version = "*",
        lazy = false,
    },
    -- "nvim-lua/plenary.nvim",
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = "VeryLazy",
        config = function()
            require("ibl").setup({
                scope = {
                    enabled = false,
                },
            })
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        -- event = "VeryLazy",
        build = function()
            require("nvim-treesitter.install").update({ with_sync = true })
        end,
        config = function()
            require("user.treesitter")
        end,
        lazy = false,
    },
    {
        "nvimtools/none-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("lsp.null-ls")
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "neovim/nvim-lspconfig",
        },
    },
    {
        "neovim/nvim-lspconfig", -- Configurations for Nvim LSP
        event = { "BufReadPre", "BufNewFile", "VeryLazy" },
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
        },
        config = function()
            require("lsp.lsp-config")
        end,
    },

    -- cmp stuff
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "onsails/lspkind.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lua",
            "rafamadriz/friendly-snippets",
        },
        config = function()
            require("user.nvim-cmp")
        end,
    },

    {
        "L3MON4D3/LuaSnip",
        lazy = false,
        version = "1.*",
        -- install jsregexp (optional!:).
        build = "make install_jsregexp",
        config = function() end,
    },
    -- telescope
    {
        event = "VeryLazy",
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "BurntSushi/ripgrep",
        },
        config = function()
            require("user.telescope")
        end,
    },

    -- bufferline
    -- {
    -- 	"akinsho/bufferline.nvim",
    -- 	event = "VeryLazy",
    -- 	version = "*",
    -- 	config = function()
    -- 		require("user.bufferline")
    -- 	end,
    -- },

    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        lazy = true,
        config = function()
            require("user.lualine")
        end,
    },

    -- handles autopairs

    {
        "akinsho/toggleterm.nvim",
        version = "*",
        lazy = true,
        config = function()
            require("user.toggleterm")
        end,
        keys = {
            [[<C-\>]],
        },
    },
    {
        "nvim-java/nvim-java",
        dependencies = {
            "nvim-java/lua-async-await",
            "nvim-java/nvim-java-core",
            "nvim-java/nvim-java-test",
            "nvim-java/nvim-java-dap",
            "MunifTanjim/nui.nvim",
            "neovim/nvim-lspconfig",
            "mfussenegger/nvim-dap",
            {
                "williamboman/mason.nvim",
                opts = {
                    registries = {
                        "github:nvim-java/mason-registry",
                        "github:mason-org/mason-registry",
                    },
                },
            },
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        lazy = true,
        event = "VeryLazy",
        config = function()
            require("gitsigns").setup()
        end,
    },
}, {
    ui = {
        border = "rounded",
    },
    defaults = {
        event = "VeryLazy",
        lazy = true,
    },
    performance = {
        cache = {
            enabled = true,
        },
    },
})
