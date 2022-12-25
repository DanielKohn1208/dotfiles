require("mason").setup({
	ui = {
		border = "rounded"
	}
})
require("mason-lspconfig").setup({
	ensure_installed = { "sumneko_lua", "cssls", "html", "jdtls", "pyright", "tsserver","marksman" },
	automatic_installation = true,
})
