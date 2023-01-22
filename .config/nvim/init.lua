require("user.options")
require("user.keymaps")
require("user.packer")
require("user.nvimtree")
require("user.treesitter")
require("user.nvim-cmp")
require("lsp.lsp-config")
require("lsp.mason")
require("user.autopairs")
require("user.comment")
require("user.telescope")
require("catppuccin").setup({
	transparent_background = false
})
vim.api.nvim_command("colorscheme catppuccin-macchiato")
require("user.bufferline")
require("user.lualine")
require("user.toggleterm")
require("lsp.null-ls")
require("user.gitsigns")
vim.cmd([[

let g:waikiki_roots = ['~/vimwiki/']
let g:waikiki_default_maps = 1
]])
