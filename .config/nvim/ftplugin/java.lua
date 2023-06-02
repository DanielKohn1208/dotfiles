-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = "/home/daniel/code/.eclipse/" .. project_name
local config = {
	cmd = { "jdtls", "-data", workspace_dir },
	root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw", "build.xml" }, { upward = true })[1]),
	settings = {
		java = {
			project = {
				referencedLibraries = {
					"/home/daniel/code/TermProject/sqlite-jdbc-3.41.2.1.jar",

				},
			},
			configuration = {
				runtimes = {

					{
						name = "JavaSE-17",
						path = "~/.sdkman/candidates/java/17.0.7-tem",
					},
					{
						name = "JavaSE-19",
						path = "~/.sdkman/candidates/java/19.0.1-oracle",
					},
				},
			},
			format = {
				enabled = false,
			},
		},
	},
	init_options = {
		bundles = {},
	},
	on_attach = function(client, bufnr)
		require("jdtls.setup").add_commands()
	end,
}

require("jdtls").start_or_attach(config)
