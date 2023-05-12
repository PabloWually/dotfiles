-- import nvim-treesitter plugin safely
local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
  return
end

require 'colorizer'.setup()

-- configure treesitter
treesitter.setup({
  -- enable syntax highlighting
  highlight = {
    enable = true,
		use_languagetree = true,
  },
  -- enable indentation
  indent = { enable = true },
  -- enable autotagging (w/ nvim-ts-autotag plugin)
  autotag = { enable = true },
  -- ensure these language parsers are installed

	rainbow = {
		enable = true,
		extended_mode = true,
		max_file_lines = nil,
	},

  ensure_installed = {
    "json",
    "javascript",
    "typescript",
    "tsx",
    "yaml",
    "html",
    "css",
    "markdown",
    "graphql",
    "bash",
		"lua",
    "vim",
    "dockerfile",
    "gitignore",
		"python",
  },
  -- auto install above language parsers
  auto_install = true,
})
