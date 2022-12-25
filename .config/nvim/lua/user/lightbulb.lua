-- Showing defaults
require("nvim-lightbulb").setup({
	ignore = {"null-ls", "gitsigns"},
	autocmd = {
		enabled = true,
		-- see :help autocmd-pattern
		pattern = { "*" },
		-- see :help autocmd-events
		events = { "CursorHold", "CursorHoldI" },
	},
})
