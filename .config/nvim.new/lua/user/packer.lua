-- Ensures packer installation
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
		vim.cmd [[packadd packer.nvim]]
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


vim.cmd [[packadd packer.nvim]]





-- Install plugins here
return require('packer').startup({ function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'
	use 'kyazdani42/nvim-web-devicons'
	use 'kyazdani42/nvim-tree.lua'
	use {
		"catppuccin/nvim",
		as = "catppuccin",
		config = function()
			vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha
			require("catppuccin").setup()
		end
	}
	use {
		'nvim-treesitter/nvim-treesitter',
		run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
	}

	use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
	use "williamboman/mason.nvim"
	use "williamboman/mason-lspconfig.nvim"

	-- cmp stuff
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'
	use 'L3MON4D3/LuaSnip'
	use 'saadparwaiz1/cmp_luasnip'
	use("hrsh7th/cmp-nvim-lua")
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

	-- telescope
	use 'nvim-telescope/telescope.nvim'
	use 'nvim-lua/plenary.nvim'
	use 'BurntSushi/ripgrep'

	use {'akinsho/bufferline.nvim', tag = "v2.*"}
	-- handles autopairs
	use {
		"windwp/nvim-autopairs",
		config = function() require("nvim-autopairs").setup {} end
	}
	--handles Comments
	use {
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end
	}
	-- setup config after cloning packer
	if packer_bootstrap then
		require('packer').sync()
	end


end,
	-- use pop up window
	config = {
		display = {
			open_fn = function()
				return require('packer.util').float({ border = 'rounded' })
			end
		}
	} })
