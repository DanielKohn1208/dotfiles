require("mason").setup({
	ui = {
		border = "rounded"
	}
})
require("mason-lspconfig").setup({
	ensure_installed = { "sumneko_lua","pyright", "cssls", "html", "jdtls", "tsserver","marksman" },
	automatic_installation = true,
})
