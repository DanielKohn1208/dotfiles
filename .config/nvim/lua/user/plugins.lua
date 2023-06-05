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
	"mfussenegger/nvim-jdtls",
	"jbyuki/nabla.nvim",
	{
		"iamcco/markdown-preview.nvim",
		lazy = false,
		build = function() vim.fn["mkdp#util#install"]() end,
	},
	-- Packer can manage itself
	-- "nvim-tree/nvim-web-devicons",
	{
		"nvim-tree/nvim-tree.lua",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("user.nvimtree")
		end,
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"catppuccin/nvim",
		as = "catppuccin",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme catppuccin-macchiato]])
		end,
	},

	-- "nvim-lua/plenary.nvim",
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "VeryLazy",
		config = function()
			require("indent_blankline").setup({
				-- for example, context is off by default, use this to turn it on
				show_current_context = true,
				-- show_current_context_start = true,
				filetype_exclude = { "dashboard" },
				config = {
					header = "DVIM"
				}

			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		event = "VeryLazy",
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
		config = function()
			require("user.treesitter")
		end,
		lazy = true,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("lsp.null-ls")
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"neovim/nvim-lspconfig"
		}
	},
	{
		"neovim/nvim-lspconfig", -- Configurations for Nvim LSP
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			require("lsp.lsp-config")
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("lsp.mason-installer")
		end,
		dependencies = {
			"williamboman/mason.nvim",
		}
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

		},
		config = function()
			require("user.nvim-cmp")
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("user.autopairs")
		end,
	},
	{
		"rafamadriz/friendly-snippets", -- a bunch of snippets to use
		lazy = false,
	},

	{
		"L3MON4D3/LuaSnip",
		version = "1.*",
		-- install jsregexp (optional!:).
		build = "make install_jsregexp",
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
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		version = "*",
		config = function()
			require("user.bufferline")
		end,
	},

	-- status line
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

	--handles Comments
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
		lazy = true,
		event = "VeryLazy",

	},

	{
		"lewis6991/gitsigns.nvim",
		lazy = true,
		event = "VeryLazy",
		config = function()
			require("gitsigns").setup()
		end,
	}
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
