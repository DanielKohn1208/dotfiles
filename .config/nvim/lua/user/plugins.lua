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
	"WhoIsSethDaniel/mason-tool-installer.nvim",
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

	"lukas-reineke/indent-blankline.nvim",

	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
	},

	"neovim/nvim-lspconfig", -- Configurations for Nvim LSP
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"jose-elias-alvarez/null-ls.nvim",

	-- cmp stuff
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/nvim-cmp",
	{
		"L3MON4D3/LuaSnip",
		version = "1.*",
		-- install jsregexp (optional!:).
		build = "make install_jsregexp",
	},
	"saadparwaiz1/cmp_luasnip",
	"hrsh7th/cmp-nvim-lua",
	"rafamadriz/friendly-snippets", -- a bunch of snippets to use

	-- telescope
	"nvim-telescope/telescope.nvim",
	"BurntSushi/ripgrep",

	-- bufferline
	{ "akinsho/bufferline.nvim", version = "*" },

	-- status line
	{
		"nvim-lualine/lualine.nvim",
	},

	-- handles autopairs
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup()
		end,
	},

	{ "akinsho/toggleterm.nvim", version = "*" },

	--handles Comments
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},

	"lewis6991/gitsigns.nvim",
}, {
	ui = {
		border = "rounded",
	},
})
