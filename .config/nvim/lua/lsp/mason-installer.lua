require("mason-tool-installer").setup({
	ensure_installed = {
		"lua-language-server",
		"pyright",
		"css-lsp",
		"html-lsp",
		"typescript-language-server",
		"autopep8",
		"stylua",
		"flake8",
		"djlint",
		"google-java-format",
	},
	run_on_start = true,
	start_delay = 3000,
})
