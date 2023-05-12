local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
	return
end

vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])

nvimtree.setup({
	-- change folder arrow icons
  renderer = {
    icons = {
      glyphs = {
        folder = {
          arrow_closed = "", -- arrow when folder is closed
          arrow_open = "", -- arrow when folder is open
        },
				git = {
					unstaged = "",
					staged = "",
					untracked = ""
				},
      },
    },
  },
  -- disable window_picker for
  -- explorer to work well with
  -- window splits
  actions = {
    open_file = {
      window_picker = {
        enable = false,
      },
    },
  },

	filters = {
    dotfiles = false,
		custom = { '^.git$' },
  },
})

require("legendary").keymaps({
	itemgroup = "Nvim-tree",
	icon = "󰙅",
	description = "Nvij tree commands",
	keymaps = {
		{"<C-]>", description = "Make Root"},
		{"a", description = "Create"},
		{"x", description = "Cut"},
		{"p", description = "Paste"},
		{"c", description = "Copy"},
		{"d", description = "Remove"},
		{"r", description = "Rename"},
		{"y", description = "Copy name"},
		{"Y", description = "Copy path"},
		{"K", description = "First sibiling"},
		{"J", description = "Last sibiling"},
		{"P", description = "Paren node"},
		{"R", description = "Refresh"},
		{"<C-v>", description = "Vertical split"},
	}
})
