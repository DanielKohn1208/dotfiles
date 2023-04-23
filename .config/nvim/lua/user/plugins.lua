-- In ~/.config/nvim/init.lua
local function clone_paq()
	local path = vim.fn.stdpath("data") .. "/site/pack/paqs/start/paq-nvim"
	local is_installed = vim.fn.empty(vim.fn.glob(path)) == 0
	if not is_installed then
		vim.fn.system({ "git", "clone", "--depth=1", "https://github.com/savq/paq-nvim.git", path })
		return true
	end
end

local function bootstrap_paq(packages)
	local first_install = clone_paq()
	vim.cmd.packadd("paq-nvim")
	local paq = require("paq")
	if first_install then
		vim.notify("Installing plugins... If prompted, hit Enter to continue.")
	end
	-- Read and install packages
	paq(packages)
	paq.install()
end

-- Call helper function
bootstrap_paq({
	"savq/paq-nvim", -- Let Paq manage itself

	"onsails/lspkind.nvim",
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	"mfussenegger/nvim-jdtls",
	"jbyuki/nabla.nvim",
	-- Packer can manage itself
	"wbthomason/packer.nvim",
	"kyazdani42/nvim-web-devicons",
	"kyazdani42/nvim-tree.lua",
	{
		"catppuccin/nvim",
		as = "catppuccin",
	},

	"nvim-lua/plenary.nvim",

	"lukas-reineke/indent-blankline.nvim",

	{
		"nvim-treesitter/nvim-treesitter",
		run = function()
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
		-- install jsregexp (optional!:).
		run = "make install_jsregexp",
	},
	"saadparwaiz1/cmp_luasnip",
	"hrsh7th/cmp-nvim-lua",
	"rafamadriz/friendly-snippets", -- a bunch of snippets to use

	-- telescope
	"nvim-telescope/telescope.nvim",
	"BurntSushi/ripgrep",

	-- bufferline
	{ "akinsho/bufferline.nvim", branch = "v3.0.0" },

	-- status line
	{
		"nvim-lualine/lualine.nvim",
	},

	-- handles autopairs
	{
		"windwp/nvim-autopairs",
	},

	"akinsho/toggleterm.nvim",

	--handles Comments
	{
		"numToStr/Comment.nvim",
	},

	"lewis6991/gitsigns.nvim",
})
-- Simple setup commands
vim.cmd([[colorscheme catppuccin-macchiato]])
require("Comment").setup()
require("nvim-autopairs").setup({})
