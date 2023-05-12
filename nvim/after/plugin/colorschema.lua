require("legendary").commands({
	itemgroup = "Color Schema",
	description = "Color theme for neovim",
	icon = "",
	commands = {
		{
			":OnedarkproCache",
			description = "Cache the theme",
		},
		{
			":OnedarkproClean",
			description = "Clean the theme cache",
		},
		{
			":OnedarkproColors",
			description = "Show the theme's colors",
		},
		-- {
		-- 	"<Leader>csd",
		-- 	":colorscheme onedark",
		-- 	description = "Change colorscheme to dark background",
		-- },
		-- {
		-- 	"<Leader>csl",
		-- 	":colorscheme onelight",
		-- 	description = "Change colorscheme to light background",
		-- },
	}
})

-- catppuccin configurtion
require('catppuccin').setup({
	flavour = "latte", -- latte, frappe, macchiato, mocha
	term_colors = true,
	transparent_background = false,
	no_italic = false,
	no_bold = false,
	integrations = {
		hop = true,
		fidget = true,
		lsp_trouble = true,
		markdown = true,
	},
	native_lsp = {
		enabled = true,
		virtual_text = {
			errors = { "italic" },
			hints = { "italic" },
			warnings = { "italic" },
			information = { "italic" },
		},
		underlines = {
			errors = { "underline" },
			hints = { "underline" },
			warnings = { "underline" },
			information = { "underline" },
		},
	},
	styles = {
		tags = {"italic"},
		methods = {"bold"},
		functions = {"bold"},
		keywords = {"italic"},
		comments = {"italic"},
		parameters = {"italic"},
		conditionals = {"italic"},
		virtual_text = {"italic"},
		strings = {},
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = {},
	},
	color_overrides = {
		latte = {
			base = "#FBF1C7",
			mantle = "#F9EBAF",
			crust = "#E0D39D",
			pink = "#BD5FA3",
			mauve = "#7A33D7",
			green = "#338022",
			teal = "#148389",
			yellow = "#A06514",
			peach = "#E45A09",
			text = "#2d2018",
			subtext1 = "#4b3628",
			subtext0 = "#5d4a3d",
			overlay2 = "#6e5e52",
			overlay1 = "#817268",
			overlay0 = "#93867e",
			surface2 = "#a59a93",
			surface1 = "#b7aea9",
			surface0 = "#c9c2be",
		},
	},
})


local opts = {
	caching = false,
	cache_path = vim.fn.expand(vim.fn.stdpath("cache") .. "/onedarkpro_dotfiles"),
	plugins = {
		barbar = false,
		lsp_saga = false,
		marks = false,
		polygot = false,
		startify = false,
		telescope = false,
		trouble = false,
		vim_ultest = false,
		which_key = false,
	},
	styles = {
		tags = "italic",
		methods = "bold",
		functions = "bold",
		keywords = "italic",
		comments = "italic",
		parameters = "italic",
		conditionals = "italic",
		virtual_text = "italic",
	},
	options = {
		cursorline = true,
		-- transparency = true,
		-- highlight_inactive_windows = true,
	},
	colors = {
		dark = {
			statusline_bg = "#2e323b",    -- gray
			statuscolumn_border = "#4b5160", -- gray
			ellipsis = "#808080",         -- gray
			telescope_prompt = "require('onedarkpro.helpers').darken('bg', 1, 'onedark')",
			telescope_results = "require('onedarkpro.helpers').darken('bg', 4, 'onedark')",
			telescope_preview = "require('onedarkpro.helpers').darken('bg', 6, 'onedark')",
			telescope_selection = "require('onedarkpro.helpers').darken('bg', 8, 'onedark')",
			copilot = "require('onedarkpro.helpers').darken('gray', 8, 'onedark')",
			breadcrumbs = "require('onedarkpro.helpers').darken('gray', 10, 'onedark')",
			local_highlight = "require('onedarkpro.helpers').lighten('bg', 2, 'onedark')",
			light_gray = "require('onedarkpro.helpers').darken('gray', 7, 'onedark')",
		},
		light = {
			comment = "#bebebe",          -- Revert back to original comment colors
			statusline_bg = "#f0f0f0",    -- gray
			statuscolumn_border = "#e7e7e7", -- gray
			ellipsis = "#808080",         -- gray
			git_add = "require('onedarkpro.helpers').get_preloaded_colors('onelight').green",
			git_modify = "require('onedarkpro.helpers').get_preloaded_colors('onelight').yellow",
			git_delete = "require('onedarkpro.helpers').get_preloaded_colors('onelight').red",
			telescope_prompt = "require('onedarkpro.helpers').darken('bg', 2, 'onelight')",
			telescope_results = "require('onedarkpro.helpers').darken('bg', 5, 'onelight')",
			telescope_preview = "require('onedarkpro.helpers').darken('bg', 7, 'onelight')",
			telescope_selection = "require('onedarkpro.helpers').darken('bg', 9, 'onelight')",
			copilot = "require('onedarkpro.helpers').lighten('gray', 8, 'onelight')",
			breadcrumbs = "require('onedarkpro.helpers').lighten('gray', 8, 'onelight')",
			local_highlight = "require('onedarkpro.helpers').darken('bg', 5, 'onelight')",
			light_gray = "require('onedarkpro.helpers').lighten('gray', 10, 'onelight')",
		},
	},
	highlights = {
		LspLens = { fg = "${light_gray}", style = "italic" },
		CursorLineNr = { bg = "${bg}", fg = "${fg}" },
		DiffChange = { style = "underline" }, -- diff mode: Changed line |diff.txt|
		LocalHighlight = { bg = "${local_highlight}" },
		MatchParen = { fg = "${cyan}" },
		ModeMsg = { fg = "${gray}" }, -- Make command line text lighter
		Search = { bg = "${selection}", fg = "${yellow}", style = "underline" },
		VimLogo = { fg = { dark = "#81b766", light = "#029632" } },
		TabLine = { fg = "${gray}", bg = "${bg}" },
		TabLineSel = { fg = "${bg}", bg = "${purple}" },
		-- Treesitter plugin
		["@text.todo.checked"] = { fg = "${bg}", bg = "${purple}" },
		-- Aerial plugin
		AerialClass = { fg = "${purple}", style = "bold,italic" },
		AerialClassIcon = { fg = "${purple}" },
		AerialConstructorIcon = { fg = "${yellow}" },
		AerialEnumIcon = { fg = "${blue}" },
		AerialFunctionIcon = { fg = "${red}" },
		AerialInterfaceIcon = { fg = "${orange}" },
		AerialMethodIcon = { fg = "${green}" },
		AerialStructIcon = { fg = "${cyan}" },
		-- Alpha
		AlphaHeader = {
			fg = { dark = "${green}", light = "${red}" },
		},
		AlphaButtonText = {
			fg = "${blue}",
			style = "bold",
		},
		AlphaButtonShortcut = {
			fg = { dark = "${green}", light = "${yellow}" },
			style = "italic",
		},
		AlphaFooter = { fg = "${gray}", style = "italic" },
		-- Bufferline
		BufferlineNormal = { bg = "${bg}", fg = "${gray}" },
		BufferlineSelected = { bg = "${statusline_bg}", fg = "${purple}" },
		BufferlineOffset = { fg = "${purple}", style = "bold" },
		-- ChatGPT
		ChatGPTWindow = { bg = "${float_bg}", fg = "${fg}" },
		ChatGPTPrompt = { bg = "${float_bg}", fg = "${fg}" },
		ChatGPTQuestion = { fg = "${blue}", style = "italic" },
		ChatGPTTotalTokens = { fg = "${bg}", bg = "${gray}" },
		ChatGPTTotalTokensBorder = { fg = "${gray}" },
		-- Cmp
		CmpItemAbbrMatch = { fg = "${blue}", style = "bold" },
		CmpItemAbbrMatchFuzzy = { fg = "${blue}", style = "underline" },
		-- Copilot
		CopilotSuggestion = { fg = "${copilot}", style = "italic" },
		-- DAP
		DebugBreakpoint = { fg = "${red}", style = "bold" },
		DebugHighlightLine = { fg = "${purple}", style = "italic" },
		NvimDapVirtualText = { fg = "${cyan}", style = "italic" },
		-- DAP UI
		DapUIBreakpointsCurrentLine = { fg = "${yellow}", style = "bold" },
		-- Fidget
		FidgetTask = { fg = "${gray}" },
		FidgetTitle = { fg = "${purple}", style = "italic" },
		-- Heirline
		Heirline = { bg = "${statusline_bg}" },
		HeirlineStatusColumn = { fg = "${statuscolumn_border}" },
		HeirlineBufferline = { fg = { dark = "#939aa3", light = "#6a6a6a" } },
		-- Luasnip
		LuaSnipChoiceNode = { fg = "${yellow}" },
		LuaSnipInsertNode = { fg = "${yellow}" },
		-- Navic
		NavicText = { fg = "${breadcrumbs}", style = "italic" },
		-- Neotest
		NeotestAdapterName = { fg = "${purple}", style = "bold" },
		NeotestFocused = { style = "bold" },
		NeotestNamespace = { fg = "${blue}", style = "bold" },
		-- Neotree
		NeoTreeRootName = { fg = "${purple}", style = "bold" },
		NeoTreeFileNameOpened = { fg = "${purple}", style = "italic" },
		-- Nvim UFO
		UfoFoldedEllipsis = { fg = "${ellipsis}" },
		-- Telescope
		TelescopeBorder = {
			fg = "${telescope_results}",
			bg = "${telescope_results}",
		},
		TelescopePromptPrefix = {
			fg = "${purple}",
		},
		TelescopePromptBorder = {
			fg = "${telescope_prompt}",
			bg = "${telescope_prompt}",
		},
		TelescopePromptCounter = { fg = "${fg}" },
		TelescopePromptNormal = { fg = "${fg}", bg = "${telescope_prompt}" },
		TelescopePromptTitle = {
			fg = "${telescope_prompt}",
			bg = "${purple}",
		},
		TelescopePreviewTitle = {
			fg = "${telescope_results}",
			bg = "${green}",
		},
		TelescopeResultsTitle = {
			fg = "${telescope_results}",
			bg = "${telescope_results}",
		},
		TelescopeMatching = { fg = "${blue}" },
		TelescopeNormal = { bg = "${telescope_results}" },
		TelescopeSelection = { bg = "${telescope_selection}" },
		TelescopePreviewNormal = { bg = "${telescope_preview}" },
		TelescopePreviewBorder = { fg = "${telescope_preview}", bg = "${telescope_preview}" },
		-- Virt Column
		VirtColumn = { fg = "${indentline}" },
	},
}

require("onedarkpro").setup(opts)

if vim.o.background == "light" then
	vim.cmd([[colorscheme onelight]])
else
	vim.cmd([[colorscheme onedark]])
end
