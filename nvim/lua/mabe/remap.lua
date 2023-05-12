local ok, legendary = pcall(require, "legendary")
if not ok then
	return
end

local opts = { noremap = true, silent = true }
--Change mode
vim.keymap.set("i", "jj", "<ESC>", opts)
vim.keymap.set("n", "<leader>vb", "<C-v>", opts)

--Manage files and split windows
vim.keymap.set("n", "<leader>nt", ":Explore<CR>", opts)
--Open terminal
vim.keymap.set("n", "<leader>te", ":split | :terminal<CR> | 10<C-W>-", opts)
--Write files and quit
vim.keymap.set("n", "<leader>w", ":w<CR>", opts)
vim.keymap.set("n", "<leader>wq", ":wq<CR>", opts)
vim.keymap.set("n", "<leader>wa", ":wa<CR>", opts)
vim.keymap.set("n", "<leader>q", ":q<CR>", opts)
vim.keymap.set("n", "<leader>Q", ":q!<CR>", opts)
vim.keymap.set("n", "<leader>qa", ":qa<CR>", opts)

-- tabs
vim.keymap.set("n", "<leader>to", ":tabnew<CR>", opts)
vim.keymap.set("n", "<leader>tx", ":tabclose<CR>", opts)
vim.keymap.set("n", "<leader>tn", ":tabn<CR>", opts)
vim.keymap.set("n", "<leader>tp", ":tabp<CR>", opts)
-- nvim-tree
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- vim-maximizer
vim.keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>", opts)

-- Functions for multiple cursors
vim.g.mc = vim.api.nvim_replace_termcodes([[y/\V<C-r>=escape(@", '/')<CR><CR>]], true, true, true)

function SetupMultipleCursors()
	vim.keymap.set(
		"n",
		"<Enter>",
		[[:nnoremap <lt>Enter> n@z<CR>q:<C-u>let @z=strpart(@z,0,strlen(@z)-1)<CR>n@z]],
		{ remap = true, silent = true }
	)
end

return legendary.keymaps({
	{ "<leader>l", ":Legendary<CR>", description = "Open remap options" },
	{ "<C-y>",     "<cmd>%y+<CR>",   hide = true,                       description = "Copy buffer" },

	{
		itemgroup = "Wrap text",
		icon = "",
		description = "Wrapping text functionality",
		keymaps = {
			{
				"<Leader>(",
				{ n = [[ciw(<c-r>")<esc>]], v = [[c(<c-r>")<esc>]] },
				description = "Wrap text in brackets ()",
			},
			{
				"<Leader>[",
				{ n = [[ciw[<c-r>"]<esc>]], v = [[c[<c-r>"]<esc>]] },
				description = "Wrap text in square braces []",
			},
			{
				"<Leader>{",
				{ n = [[ciw{<c-r>"}<esc>]], v = [[c{<c-r>"}<esc>]] },
				description = "Wrap text in curly braces {}",
			},
			{
				'<Leader>"',
				{ n = [[ciw"<c-r>""<esc>]], v = [[c"<c-r>""<esc>]] },
				description = 'Wrap text in quotes ""',
			},
		},
	},
	{
		itemgroup = "Find and Replace",
		icon = "",
		description = "Find and replace within the buffer",
		keymaps = {
			{
				"<Leader>fw",
				[[:%s/\<<C-r>=expand("<cword>")<CR>\>/]],
				description = "Replace cursor words in buffer",
			},
			{
				"<Leader>fl",
				[[:s/\<<C-r>=expand("<cword>")<CR>\>/]],
				description = "Replace cursor words in line",
			},
		},
	},
	{
		itemgroup = "Working with lines",
		icon = "",
		description = "Movine lines, adding comas, etc",
		keymaps = {
			-- Working with lines
			{ "B",         "^",                description = "Beginning of a line",    mode = { "n", "v" } },
			{ "E",         "$",                description = "End of a line",          mode = { "n", "v" } },
			{ "<CR>",      "o<ESC>",                description = "Insert blank line below" },
			{ "<S-CR>",    "O<ESC>",                description = "Insert blank line above" },
			-- Editing words
			{ "<Leader>,", "<cmd>norm A,<CR>", description = "Append comma" },
			{
				"<Leader>;",
				"<cmd>norm A;<CR>",
				description = "Append semicolon",
			},
			-- Moving lines
			{
				"<A-k>",
				{
					n = ":m .-2<CR>==",
					v = ":m '<-2<CR>gv=gv",
				},
				description = "Move selection up",
				opts = { silent = true },
			},
			{
				"<A-j>",
				{
					n = ":m .+1<CR>==",
					v = ":m '>+1<CR>gv=gv",
				},
				description = "Move selection down",
				opts = { silent = true },
			},
			{ ">", ">gv", description = "Indent",  mode = { "v" } },
			{ "<", "<gv", description = "Outdent", mode = { "v" } },
		},
	},
	{
		itemgroup = "Split windows",
		icon = "",
		description = "Worling with split windows",
		keymaps = {
			-- Splits
			{ "<Leader>sv", "<C-w>v",   description = "Split: Vertical" },
			{ "<Leader>sh", "<C-w>h",   description = "Split: Horizontal" },
			{ "<Leader>se", "<C-w>=",   description = "Split: Equal size" },
			{ "<Leader>>",  "10<C-w>>", description = "Split: Increase size" },
			{ "<Leader><",  "10<C-w><", description = "Split: Reduce size" },
			{ "<Leader>sc", "<C-w>q",   description = "Split: Close" },
			{ "<Leader>so", "<C-w>o",   description = "Split: Close all but current" },
		},
	},
	-- {
	-- 	itemgroup = "Split windows",
	-- 	icon = "",
	-- 	description = "Worling with split windows",
	-- 	keymaps = {
	--
	-- 	},
	-- },
	-- Misc
	{ "<Esc>",     "<cmd>:noh<CR>",        description = "Clear searches" },
	{ "<S-w>",     "<cmd>set winbar=<CR>", description = "Hide WinBar" },
	{ "<Leader>U", "gUiw`",                description = "Capitalize word" },

	-- Multiple Cursors
	-- http://www.kevinli.co/posts/2017-01-19-multiple-cursors-in-500-bytes-of-vimscript/
	-- https://github.com/akinsho/dotfiles/blob/45c4c17084d0aa572e52cc177ac5b9d6db1585ae/.config/nvim/plugin/mappings.lua#L298

	-- 1. Position the cursor anywhere in the word you wish to change;
	-- 2. Or, visually make a selection;
	-- 3. Hit cn, type the new word, then go back to Normal mode;
	-- 4. Hit `.` n-1 times, where n is the number of replacements.
	{
		itemgroup = "Multiple Cursors",
		icon = "",
		description = "Working with multiple cursors",
		keymaps = {
			{
				"cn",
				{
					n = { "*``cgn" },
					x = { [[g:mc . "``cgn"]], opts = { expr = true } },
				},
				description = "Inititiate",
			},
			{
				"cN",
				{
					n = { "*``cgN" },
					x = { [[g:mc . "``cgN"]], opts = { expr = true } },
				},
				description = "Inititiate (in backwards direction)",
			},

			-- 1. Position the cursor over a word; alternatively, make a selection.
			-- 2. Hit cq to start recording the macro.
			-- 3. Once you are done with the macro, go back to normal mode.
			-- 4. Hit Enter to repeat the macro over search matches.
			{
				"cq",
				{
					n = { [[:\<C-u>call v:lua.SetupMultipleCursors()<CR>*``qz]] },
					x = {
						[[":\<C-u>call v:lua.SetupMultipleCursors()<CR>gv" . g:mc . "``qz"]],
						opts = { expr = true },
					},
				},
				description = "Inititiate with macros",
			},
			{
				"cQ",
				{
					n = { [[:\<C-u>call v:lua.SetupMultipleCursors()<CR>#``qz]] },
					x = {
						[[":\<C-u>call v:lua.SetupMultipleCursors()<CR>gv" . substitute(g:mc, '/', '?', 'g') . "``qz"]],
						opts = { expr = true },
					},
				},
				description = "Inititiate with macros (in backwards direction)",
			},
		},
	},
})
