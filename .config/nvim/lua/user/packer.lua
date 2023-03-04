-- Ensures packer installation
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

-- Install all plugins on write
vim.cmd([[
augroup packer_user_config
	autocmd!
	autocmd BufWritePost packer.lua source <afile> | PackerInstall
augroup end
]])

vim.cmd([[packadd packer.nvim]])

-- Install plugins here
return require("packer").startup({
	function(use)
		use "sbdchd/vim-run"
		use("WhoIsSethDaniel/mason-tool-installer.nvim")
		use("mfussenegger/nvim-jdtls")
		use({
			"iamcco/markdown-preview.nvim",
			run = "cd app && npm install",
			setup = function()
				vim.g.mkdp_filetypes = { "markdown" }
			end,
			ft = { "markdown" },
		})
		use("jbyuki/nabla.nvim")
		-- Packer can manage itself
		use("wbthomason/packer.nvim")
		use("kyazdani42/nvim-web-devicons")
		use("kyazdani42/nvim-tree.lua")

		use({
			"catppuccin/nvim",
			as = "catppuccin",
		})

		use("nvim-lua/plenary.nvim")

		use("lukas-reineke/indent-blankline.nvim")

		use({
			"nvim-treesitter/nvim-treesitter",
			run = function()
				require("nvim-treesitter.install").update({ with_sync = true })
			end,
		})

		use("neovim/nvim-lspconfig") -- Configurations for Nvim LSP
		use("williamboman/mason.nvim")
		use("williamboman/mason-lspconfig.nvim")
		use("jose-elias-alvarez/null-ls.nvim")

		-- cmp stuff
		use("hrsh7th/cmp-nvim-lsp")
		use("hrsh7th/cmp-buffer")
		use("hrsh7th/cmp-path")
		use("hrsh7th/cmp-cmdline")
		use("hrsh7th/nvim-cmp")
		use({
			"L3MON4D3/LuaSnip",
			-- follow latest release.
			tag = "v<CurrentMajor>.*",
			-- install jsregexp (optional!:).
			run = "make install_jsregexp",
		})
		use("saadparwaiz1/cmp_luasnip")
		use("hrsh7th/cmp-nvim-lua")
		use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

		-- telescope
		use("nvim-telescope/telescope.nvim")
		use("BurntSushi/ripgrep")

		-- bufferline
		use({ "akinsho/bufferline.nvim", tag = "v3.*", requires = "kyazdani42/nvim-web-devicons" })

		-- status line
		use({
			"nvim-lualine/lualine.nvim",
			requires = { "kyazdani42/nvim-web-devicons", opt = true },
		})

		-- handles autopairs
		use({
			"windwp/nvim-autopairs",
			config = function()
				require("nvim-autopairs").setup({})
			end,
		})

		-- toggle term
		use({
			"akinsho/toggleterm.nvim",
			tag = "*",
		})

		--handles Comments
		use({
			"numToStr/Comment.nvim",
			config = function()
				require("Comment").setup()
			end,
		})

		use({
			"lewis6991/gitsigns.nvim",
		})
		-- setup config after cloning packer
		if packer_bootstrap then
			require("packer").sync()
		end
	end,
	-- use pop up window
	config = {
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "rounded" })
			end,
		},
	},
})
