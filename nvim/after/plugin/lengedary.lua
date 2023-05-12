local setup, legendary = pcall(require, "legendary")
if not setup then
	return
end

legendary.setup({
	dependencies = "kkharji/sqlite.lua",
	select_prompt = "Legendary",
	include_builtin = false,
	include_legendary_cmds = false,
	which_key = { auto_register = false },
	keymaps = {
		{
			"<C-p>",
			require("legendary").find,
			hide = true,
			description = "Open Legendary",
			mode = { "n", "v" },
		},

		{
			itemgroup = "Harpoon",
			icon = "異",
			description = "Harpoon functionality...",
			keymaps = {
				{ "<C-e>", "<cmd>Telescope harpoon marks<CR>", description = "Show marks whit telescope" },
				{ "<A-e>", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", description = "Show marks" },
				{ "<Leader>a", "<cmd>lua require('harpoon.mark').add_file()<CR>", description = "Add file" },
				{ "<A-n>", "<cmd>lua require('harpoon.ui').nav_next()<CR>", description = "Next marked file"},
				{ "<A-p>", "<cmd>lua require('harpoon.ui').nav_prev()<CR>", description = "Previous marked file"},
			},
		},
	},
})
