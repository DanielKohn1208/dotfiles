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
	"onsails/lspkind.nvim",
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		lazy = true,
	},
	"mfussenegger/nvim-jdtls",
	"jbyuki/nabla.nvim",
	-- Packer can manage itself
	"nvim-tree/nvim-web-devicons",
	"nvim-tree/nvim-tree.lua",
	{
		"catppuccin/nvim",
		as = "catppuccin",
		config = function()
			vim.cmd([[colorscheme catppuccin-macchiato]])
		end,
	},

	"nvim-lua/plenary.nvim",

	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufEnter",
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
		lazy = true,
	},

	{
		"neovim/nvim-lspconfig", -- Configurations for Nvim LSP
		lazy = true,
		event = "InsertEnter",
		config = function() 
			require("lsp.null-ls")
		end,
	},
	{
		"williamboman/mason.nvim",
	},

	"williamboman/mason-lspconfig.nvim",
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "BufEnter",
		config = function()
			require("lsp.null-ls")
		end,
	},

	-- cmp stuff
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lua",
			{
				"windwp/nvim-autopairs",
				config = function()
					require("user.autopairs")
				end,
			},
		},
		config = function()
			require("user.nvim-cmp")
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
	"nvim-telescope/telescope.nvim",
	"BurntSushi/ripgrep",

	-- bufferline
	{ "akinsho/bufferline.nvim", version = "*" },

	-- status line
	{
		event = "BufEnter",
		"nvim-lualine/lualine.nvim",
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
			[[<C-\>]]
		}
	},

	--handles Comments
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
		lazy = true,
		keys = {
			"gcc",
		},
	},

	"lewis6991/gitsigns.nvim",
}, {
	ui = {
		border = "rounded",
	},
	defaults = {
		lazy = true,
	},
	performance = {
		cache = {
			enabled = true,
		},
	},
})
