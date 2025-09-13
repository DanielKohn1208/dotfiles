require("mini.comment").setup()
require("mini.pairs").setup()
require("mini.tabline").setup()

-- Centering for picker
local max_height = 10
local max_width = 60
local win_config = function()
	local height = math.min(math.floor(0.618 * vim.o.lines), max_height)
	local width = math.min(math.floor(0.9 * vim.o.columns), max_width)
	return {
		border = "rounded",
		anchor = "NW",
		height = height,
		width = width,
		row = math.floor(0.2 * (vim.o.lines - height)),
		col = math.floor(0.5 * (vim.o.columns - width)),
	}
end

require("mini.pick").setup({
	mappings = {
		move_up = "<C-k>",
		move_down = "<C-j>",
	},
	window = { config = win_config },
})
require("mini.extra").setup()
-- require("mini.icons").setup()
-- require("mini.snippets").setup()
-- require("mini.completion").setup({
-- 	window = {
-- 		info = {
-- 			border = "rounded",
-- 		},
-- 		signature = {
-- 			border = "rounded",
-- 		},
-- 	},
-- })
-- -- weird trick from ChatGPT to cycle through completion options with tab and s-tab
-- vim.api.nvim_set_keymap(
-- 	"i",
-- 	"<Tab>",
-- 	[[pumvisible() ? "\<C-n>" : "\<Tab>"]],
-- 	{ noremap = true, expr = true, silent = true }
-- )
-- vim.api.nvim_set_keymap(
-- 	"i",
-- 	"<S-Tab>",
-- 	[[pumvisible() ? "\<C-p>" : "\<C-h>"]],
-- 	{ noremap = true, expr = true, silent = true }
-- )
-- vim.api.nvim_set_keymap('i', '<CR>', [[pumvisible() ? "\<C-y>" : "\<CR>"]],
--   { noremap = true, expr = true, silent = true })
