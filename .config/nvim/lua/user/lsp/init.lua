require("mason").setup({})

require("mason-lspconfig").setup({})

local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("user.lsp.handlers").setup()
lspconfig.sumneko_lua.setup {
	capabilities = require("user.lsp.handlers").capabilities,
	on_attach = require("user.lsp.handlers").on_attach,
	root_dir = function() return vim.loop.cwd() end,      -- run lsp for javascript in any directory

	settings = {

		Lua = {
			diagnostics = {
				globals = { "vim", "awesome", "client", "root", "screen"},
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},

}
lspconfig.cssls.setup {
	capabilities = require("user.lsp.handlers").capabilities,
	on_attach = require("user.lsp.handlers").on_attach,

}
lspconfig.jdtls.setup {
	capabilities = require("user.lsp.handlers").capabilities,
	on_attach = require("user.lsp.handlers").on_attach,

}
lspconfig.html.setup {
	capabilities = require("user.lsp.handlers").capabilities,
	on_attach = require("user.lsp.handlers").on_attach,

}
lspconfig.tsserver.setup {
	capabilities = require("user.lsp.handlers").capabilities,
	on_attach = require("user.lsp.handlers").on_attach,
	root_dir = function() return vim.loop.cwd() end      -- run lsp for javascript in any directory

}

lspconfig.pyright.setup {
	capabilities = require("user.lsp.handlers").capabilities,
	on_attach = require("user.lsp.handlers").on_attach,
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "off",
			}
		}
	},
}

require("user.lsp.null-ls")

