local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
	return
end

local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
	return
end

local t = require("legendary.toolbox")
local b = require("telescope.builtin")
require("legendary").keymaps({
	{
		itemgroup = "Telescope",
		description = "Gaze deeply into unknown regions using the power of the moon",
		icon = "",
		keymaps = {
			{
				"<leader>ff",
				t.lazy_required_fn("telescope.builtin", "find_files", { hidden = true }),
				description = "Find files",
			},
			{
				"<leader>fs",
				t.lazy_required_fn(
					"telescope.builtin",
					"live_grep",
					{ prompt_title = "Open Files", path_display = { "shorten" }, grep_open_files = true }
				),
				description = "Find in open files",
			},
			{
				"<leader>fc",
				t.lazy_required_fn("telescope.builtin", "grep_string", { path_display = { "smart" } }),
				description = "Find string",
			},
			{
				"<Leader>fw",
				t.lazy_required_fn(
					"telescope.builtin",
					"live_grep",
					{ prompt_title = "Search CWD", path_display = { "smart" } }
				),
				description = "Search CWD",
			},
			{
				"<leader>fb",
				t.lazy_required_fn(
					"telescope.builtin",
					"buffers",
					{ prompt_title = "Buffer List", path_display = { "smart" } }
				),
				description = "List buffers",
			},
			{
				"<Leader>fr",
				"<cmd>lua require('telescope').extensions.frecency.frecency({ prompt_title = 'Recent Files', workspace = 'CWD' })<CR>",
				description = "Find recent files",
			},
			{
				"<Leader>ft",
				"<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>",
				description = "File Explorer",
			},
			{
				"<Leader>gs",
				"<cmd>Telescope git_status<CR>",
				description = "Git status",
			},
			{
				"<Leader>gb",
				"<cmd>Telescope git_branches<CR>",
				description = "Git brances",
			},
			{
				"<Leader>gm",
				"<cmd>Telescope git_commits<CR>",
				description = "Git commits",
			},
		},
	},
})

telescope.setup({
	defaults = {
		-- Appearance
		entry_prefix = "  ",
		prompt_prefix = "   ",
		selection_caret = "  ",
		color_devicons = true,
		path_display = { "smart" },
		dynamic_preview_title = true,
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				preview_width = 0.55,
				prompt_position = "top",
				width = 0.9,
			},
			center = {
				anchor = "N",
				width = 0.9,
				preview_cutoff = 10,
			},
			vertical = {
				height = 0.9,
				preview_height = 0.3,
				width = 0.9,
				preview_cutoff = 10,
				prompt_position = "top",
			},
		},
		-- Searching
		set_env = { COLORTERM = "truecolor" },
		file_ignore_patterns = {
			".git/",
			"%.csv",
			"%.jpg",
			"%.jpeg",
			"%.png",
			"%.svg",
			"%.otf",
			"%.ttf",
			"%.lock",
			"__pycache__",
			"%.sqlite3",
			"%.ipynb",
			"vendor",
			"node_modules",
			"dotbot",
		},
		file_sorter = require("telescope.sorters").get_fuzzy_file,
		mappings = {
			i = {
				["<esc>"] = actions.close,
				["<C-c>"] = actions.delete_buffer,
				["<C-j>"] = actions.move_selection_next,
				["<C-d>"] = actions.preview_scrolling_down,
				["<C-f>"] = actions.preview_scrolling_up,
				["<C-k>"] = actions.move_selection_previous,
				["<C-q>"] = actions.send_to_qflist,
			},
		},
	},
	extensions = {
		frecency = {
			show_scores = false,
			show_unindexed = true,
			ignore_patterns = {
				"*.git/*",
				"*/tmp/*",
				"*/node_modules/*",
				"*/vendor/*",
			},
		},
		fzy_native = {
			override_generic_sorter = true,
			override_file_sorter = true,
		},
		fzf_writer = {
			use_highlighter = false,
			minimum_grep_characters = 6,
		},
	},
})

telescope.load_extension("fzf")
telescope.load_extension("file_browser")
telescope.load_extension("ui-select")
telescope.load_extension("frecency")
telescope.load_extension("persisted")
