vim.opt.termguicolors = true
vim.cmd [[highlight IndentBlanklineContextChar guifg=#fca311 gui=nocombine]]

vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"

require("indent_blankline").setup {
	use_treesitter = true,
	-- show_first_indent_level = false,

	char = "¦",
	space_char_blankline = " ",
	show_current_context = true,
	show_current_context_start = true,
	-- buftype_exclude = {"terminal", "nofile"},
}
