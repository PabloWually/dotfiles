local setup, persisted = pcall(require, "persisted")
if not setup then
	return
end

persisted.setup {
	save_dir = vim.fn.stdpath("data") .. "/sessions/",
	use_git_branch = true,
	silent = true,
	autoload = true,
}
require("legendary").keymaps({
	{
		itemgroup = "Persisted",
		icon = "",
		description = "Session management...",
		keymaps = {
			{
				"<Leader>s",
				'<cmd>lua require("persisted").toggle()<CR>',
				description = "Toggle a session",
				opts = { silent = true },
			},
		},
	},
})
require("legendary").commands({
	{
		itemgroup = "Persisted",
		commands = {
			{
				":Sessions",
				function() vim.cmd([[Telescope persisted]]) end,
				description = "List sessions",
			},
			{
				":SessionSave",
				description = "Save the session",
			},
			{
				":SessionStart",
				description = "Start a session",
			},
			{
				":SessionStop",
				description = "Stop the current session",
			},
			{
				":SessionLoad",
				description = "Load the last session",
			},
			{
				":SessionDelete",
				description = "Delete the current session",
			},
		},
	},
})
