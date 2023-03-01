require("mason").setup({
	ui = {
		border = "rounded",
	},
})
-- require("mason-lspconfig").setup({
-- 	ensure_installed = { "sumneko_lua","pyright", "cssls", "html", "tsserver" },
-- 	automatic_installation = true,
-- })
require("mason-tool-installer").setup({
	ensure_installed = {
		"lua-language-server",
		"pyright",
		"css-lsp",
		"emmet-ls",
		"html-lsp",
		"typescript-language-server",
		"autopep8",
		"stylua",
		"flake8",
		"djlint",
	},
	run_on_start = true,
	start_delay = 3000,
})
