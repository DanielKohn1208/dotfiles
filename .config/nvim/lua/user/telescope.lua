local actions = require "telescope.actions"
require('telescope').setup {
	defaults = {
		prompt_prefix = " ",
		selection_caret = " ",
		path_display = { "smart" },

		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			}
		}
	},
	pickers = {
		-- builtin picker
	},
	extensions = {
	}
}
