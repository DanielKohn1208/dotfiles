-- Set up nvim-cmp.
local cmp = require("cmp")

local luasnip = require("luasnip")
local lspkind = require("lspkind")
local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
require("luasnip.loaders.from_vscode").lazy_load({
	exclude = { "tex", "latex", "global" },
}) -- loading snippets from vs code

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol_text", -- show only symbol annotations
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
			-- The function below will be called before any actual modifications from lspkind
			-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
			before = function(entry, vim_item)
				-- ...
				return vim_item
			end,
		}),
	},
	-- formatting = {
	-- 	fields = { "abbr", "menu" },
	-- 	format = function(entry, vim_item)
	-- 		vim_item.menu = ({
	-- 			nvim_lsp = "[LSP]",
	-- 			nvim_lua = "[LUA]",
	-- 			luasnip = "[SNIP]",
	-- 			buffer = "[BUFF]",
	-- 			path = "[PATH]",
	-- 		})[entry.source.name]
	-- 		return vim_item
	-- 	end,
	-- },
	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping.scroll_docs(-4),
		["<C-j>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
				-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
				-- they way you will only jump inside the snippet region
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	}),
	sources = cmp.config.sources({
		{ name = "luasnip" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lua" },
	}, {
		{ name = "buffer" },
		{ name = "path" },
	}),
})

cmp.setup.filetype('tex',{
	sources = cmp.config.sources({
		{name = "luasnip"},
		{name = "nvim_lsp"}
	}
	)
})
-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({
		{ name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
	}, {
		{ name = "buffer" },
	}),
})

------ THIS IS WHERE WE DEFINE OUR OWN SNIPPETS ------
local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.conditions")
local conds_expand = require("luasnip.extras.conditions.expand")

local rec_ls
rec_ls = function()
	return sn(
		nil,
		c(1, {
			-- Order is important, sn(...) first would cause infinite loop of expansion.
			t(""),
			sn(nil, { t({ "", "\t\\item " }), i(1), d(2, rec_ls, {}) }),
		})
	)
end
local function fn(
	args -- text from i(2) in this example i.e. { { "456" } }
)
	return args[1][1]
end

luasnip.add_snippets("tex", {
	s("ls", {
		t({ "\\begin{itemize}", "\t\\item " }),
		i(1, "first item"),
		d(2, rec_ls, {}),
		t({ "", "\\end{itemize}" }),
	}),
	s("//", {
		t("\\frac{"),
		i(1, "num"),
		t("}{"),
		i(2, "den"),
		t("}"),
	}),
	s("int", {
		t({ "\\int_{" }),
		i(1),
		t("}^{"),
		i(2),
		t("}"),
		i(3, "f(x)dx"),
	}),
	s("sum", {
		t({ "\\sum_{" }),
		i(1),
		t("}^{"),
		i(2),
		t("}"),
		i(3),
	}),
	s("beg", {
		t({ "\\begin{" }),
		i(1),
		t({ "}", "\t" }),
		i(2),
		t({ "", "\\end{" }),
		f(fn, { 1 }),
		t("}"),
	}),
	s("ve", {
		t("\\vec{"),
		i(1),
		t("}"),
	}),
	s("al", t("\\alpha")),
	s("De", t("\\Delta")),
	s("de", t("\\delta")),
	s("be", t("\\Beta")),
	s("ep", t("\\epsilon")),
	s("lim",{
		t('\\lim_{'),
		i(1,'x'),
		t(' \\to '),
		i(2,'a'),
		t('}'),
		i(3,'f(x)')
	}),
	s("$", {
		t('$'),
		i(1),
		t('$'),
		i(2)
	})
})
