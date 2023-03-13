-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
--
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = "/home/daniel/code/.eclipse/" .. project_name
local config = {
	-- The command that starts the language server
	-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
	--
	cmd = { "jdtls", "-data", workspace_dir },
	-- 💀
	-- This is the default if not provided, you can remove it. Or adjust as needed.
	-- Here you can configure eclipse.jdt.ls specific settings
    root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw', 'build.xml'}, { upward = true})[1]),
	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	-- for a list of options
	settings = {
	},
	-- Language server `initializationOptions`
	-- You need to extend the `bundles` with paths to jar files
	-- if you want to use additional eclipse.jdt.ls plugins.
	--
	-- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
	--
	-- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
	init_options = {
		bundles = {},
	},
	on_attach = function(client, bufnr)
		require("jdtls.setup").add_commands()
	end,
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.

require("jdtls").start_or_attach(config)
