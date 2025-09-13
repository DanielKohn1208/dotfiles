local M = {}

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
-- Diagnostics
local config = {
	-- disable virtual text
	virtual_text = false,
	-- show signs
	signs = {
		active = signs,
	},
	update_in_insert = true,
	underline = false,
	severity_sort = true,
	float = {
		focusable = true,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "rounded",
})

vim.diagnostic.config(config)
-- 

-- Keymaps
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Mason stuff
require("mason").setup()



-- Lsp setup
M.on_attach = function(client, bufnr)
	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", "<cmd>Pick lsp scope='implementations'<cr>", bufopts)
	vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", "<cmd>Pick lsp scope='references'<cr>", bufopts)
	vim.keymap.set("n", "<space>f", function()
		vim.lsp.buf.format({ async = true })
	end, bufopts)
end

-- Specific LSPs

local capabilities = vim.lsp.protocol.make_client_capabilities()

vim.lsp.config('*', {
	on_attach = M.on_attach,
	capabilities = capabilities
})

vim.lsp.config("lua_ls", {
	on_attach = M.on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim", "awesome", "client", "root", "screen" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})

vim.lsp.config("pyright", {
	on_attach = M.on_attach,
	capabilities = capabilities,
	settings = {
		pyright = {
			disableOrganizeImports = false
		},
		python = {
			analysis = {
				autoImportCompletion = true,
				autoSearchPaths = true,
				typeCheckingMode = "off", -- might use off here in the future
				useLibraryCodeForTypes = true,
			},
		},
	},
})

-- Automatic installs/enables
require("mason-lspconfig").setup({
	automatic_enable = true
})


return M
