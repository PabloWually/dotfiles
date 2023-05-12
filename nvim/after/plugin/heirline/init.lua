---Load the bufferline, tabline and statusline. Extracting this to a seperate
local heirline = require("heirline")
local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local colors = {
	text = "#e9d8a6",
	normalMode = "#577590",
	inserMode = "#90be6d",
	visualMode = "#ca6702",
	commandMode = "#ee9b00",
	smode = "#277da1",
	replaceMode = "#f9844a",
	branch = "#f3722c",
	git_sing = "#14213d",
	file_info = "#161a1d",
	error = "#D62828",
	warning = "#fca311",
	added = "#6A994E",
	info = "#88c0d0",
	hint = "#5e81ac",
	lsp = "#5e81ac",
	rule = "#52a1a3",
}

-- Filetypes where certain elements of the statusline will not be shown
local filetypes = {
	"^git.*",
	"fugitive",
	"alpha",
	"^neo--tree$",
	"^neotest--summary$",
	"^neo--tree--popup$",
	"^NvimTree$",
	"^toggleterm$",
}

-- Buftypes which should cause elements to be hidden
local buftypes = {
	"nofile",
	"prompt",
	"help",
	"quickfix",
}

-- Filetypes which force the statusline to be inactive
local force_inactive_filetypes = {
	"^aerial$",
	"^alpha$",
	"^chatgpt$",
	"^DressingInput$",
	"^frecency$",
	"^lazy$",
	"^netrw$",
	"^oil$",
	"^TelescopePrompt$",
	"^undotree$",
}

local StatusLine = {
	VimMode = {
		init = function(self)
			self.mode = vim.fn.mode(1)
			self.mode_color = self.mode_colors[self.mode:sub(1, 1)]
		end,

		static = {
			mode_names = {
				n = "NORMAL",
				no = "NORMAL",
				nov = "NORMAL",
				noV = "NORMAL",
				["no\22"] = "NORMAL",
				niI = "NORMAL",
				niR = "NORMAL",
				niV = "NORMAL",
				nt = "NORMAL",
				v = "VISUAL",
				vs = "VISUAL",
				V = "VISUAL",
				Vs = "VISUAL",
				["\22"] = "VISUAL",
				["\22s"] = "VISUAL",
				s = "SELECT",
				S = "SELECT",
				["\19"] = "SELECT",
				i = "INSERT",
				ic = "INSERT",
				ix = "INSERT",
				R = "REPLACE",
				Rc = "REPLACE",
				Rx = "REPLACE",
				Rv = "REPLACE",
				Rvc = "REPLACE",
				Rvx = "REPLACE",
				c = "COMMAND",
				cv = "Ex",
				r = "...",
				rm = "M",
				["r?"] = "?",
				["!"] = "!",
				t = "TERM",
			},
			mode_colors = {
				n = colors.normalMode,
				i = colors.inserMode,
				v = colors.visualMode,
				V = colors.visualMode,
				["\22"] = colors.commandMode,
				c = colors.commandMode,
				s = colors.smode,
				S = colors.smode,
				["\19"] = colors.smode,
				r = colors.replaceMode,
				R = colors.replaceMode,
				["!"] = colors.commandMode,
				t = colors.commandMode,
			},
		},
		{
			provider = "",
			hl = function(self)
				return { fg = self.mode_color, bg = "bg" }
			end,
		},
		{
			provider = function(self)
				local mode = self.mode:sub(1, 1)
				return " %2(" .. self.mode_names[self.mode] .. "%) "
			end,
			hl = function(self)
				return {
					fg = colors.text,
					bg = self.mode_color,
					bold = true,
				}
			end,
			on_click = {
				callback = function()
					vim.cmd("Alpha")
				end,
				name = "heirline_mode",
			},
		},
	},
	Git = {
		condition = conditions.is_git_repo,

		init = function(self)
			self.status_dict = vim.b.gitsigns_status_dict
			self.has_changes = self.status_dict.added ~= 0
				or self.status_dict.removed ~= 0
				or self.status_dict.changed ~= 0
		end,
		hl = function(self)
			return { bg = colors.branch, fg = colors.text }
		end,

		{ -- git branch name
			provider = function(self)
				return "%2(%) " .. "%2(" .. self.status_dict.head .. " %)"
			end,
			hl = { bold = true },
		},

		-- You could handle delimiters, icons and counts similar to Diagnostics
		{
			provider = function(self)
				local count = self.status_dict.added or 0
				return count > 0 and ("%2(%)" .. "%2( " .. count .. " %)")
			end,
			hl = { fg = colors.added, bg = colors.git_sing },
		},
		{
			provider = function(self)
				local count = self.status_dict.removed or 0
				return count > 0 and ("%2(%)" .. "%2( " .. count .. " %)")
			end,
			hl = { fg = colors.error, bg = colors.git_sing },
		},
		{
			provider = function(self)
				local count = self.status_dict.changed or 0
				return count > 0 and ("%2(󱔀%)" .. "%2( " .. count .. " %)")
			end,
			hl = { fg = colors.warning, bg = colors.git_sing },
		},
	},
	LSPActive = {
		condition = conditions.lsp_attached,
		update = { "LspAttach", "LspDetach" },

		-- You can keep it simple,
		-- provider = " [LSP]",

		-- Or complicate things a bit and get the servers names
		provider = function()
			local names = {}
			for i, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
				table.insert(names, server.name)
			end
			return " [" .. table.concat(names, " ") .. "]"
		end,
		hl = { fg = colors.text, bg = colors.lsp, bold = true },
	},
	Diagnostics = {
		condition = conditions.has_diagnostics,
		init = function(self)
			self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
			self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
			self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
			self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
		end,
		on_click = {
			callback = function()
				vim.cmd("normal gf")
			end,
			name = "heirline_diagnostics",
		},
		update = { "DiagnosticChanged", "BufEnter" },
		-- Errors

		{
			provider = function(self)
				-- 0 is just another output, we can decide to print it or not!
				return self.errors > 0 and (vim.fn.sign_getdefined("DiagnosticSignError")[1].text .. self.errors .. " ")
			end,
			hl = { fg = colors.error, bg = colors.git_sing },
		},
		-- Warnings
		{
			provider = function(self)
				return self.warnings > 0
					and (vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text .. self.warnings .. " ")
			end,
			hl = { fg = colors.warning, bg = colors.git_sing },
		},
		-- Hints
		{
			hl = { fg = colors.hint, bg = colors.git_sing },

			provider = function(self)
				return self.hints > 0 and vim.fn.sign_getdefined("DiagnosticSignHint")[1].text .. self.hints .. " "
			end,
		},
		-- Info
		{
			hl = { bg = colors.info, fg = colors.git_sing },

			provider = function(self)
				return self.info > 0 and vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text .. self.info .. "2"
			end,
		},
	},
	FileEncoding = {
		condition = function(self)
			return not conditions.buffer_matches({
				filetype = self.filetypes,
			})
		end,
		{
			provider = function()
				local enc = (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc -- :h 'enc'
				return " " .. enc .. " "
			end,
			hl = {
				fg = colors.text,
				bg = colors.file_info,
			},
		},
	},
	ScrollBar = {
		static = {
			sbar = {
				" ",
				" ",
				" ",
				" ",
				" ",
				" ",
				" ",
				" ",
				" ",
				" ",
				" ",
				" ",
				" ",
				" ",
				" ",
				" ",
				" ",
				" ",
				" ",
				" ",
				" ",
				" ",
				" ",
				" ",
				" ",
				" ",
				" ",
				" ",
			},

			-- Another variant, because the more choice the better.
			-- sbar = { '🭶', '🭷', '🭸', '🭹', '🭺', '🭻' }
		},
		provider = function(self)
			local curr_line = vim.api.nvim_win_get_cursor(0)[1]
			local lines = vim.api.nvim_buf_line_count(0)
			local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
			return " " .. self.sbar[i]
		end,
		hl = { fg = colors.text, bg = colors.rule },
	},
	Ruler = {
		condition = function(self)
			return not conditions.buffer_matches({
				filetype = self.filetypes,
			})
		end,

		{
			-- %L = number of lines in the buffer
			-- %P = percentage through file of displayed window
			provider = "%7(%l/%3L%):%2c %P",
			hl = { fg = colors.text, bg = colors.rule },
			on_click = {
				callback = function()
					local line = vim.api.nvim_win_get_cursor(0)[1]
					local total_lines = vim.api.nvim_buf_line_count(0)

					if math.floor((line / total_lines)) > 0.5 then
						vim.cmd("normal! gg")
					else
						vim.cmd("normal! G")
					end
				end,
				name = "heirline_ruler",
			},
		},
	},
}
local FileBlock = {
	init = function(self)
		self.filename = vim.api.nvim_buf_get_name(0)
	end,
	condition = function(self)
		return not conditions.buffer_matches({
			filetype = self.filetypes,
		})
	end,
}
local FileIcon = {
	init = function(self)
		local filename = self.filename
		local extension = vim.fn.fnamemodify(filename, ":e")
		self.icon, self.icon_color =
			require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
	end,
	provider = function(self)
		return self.icon and (" " .. self.icon)
	end,
	hl = function(self)
		return { fg = self.icon_color, bg = colors.file_info }
	end,
}
local FileName = {
	provider = function(self)
		local filename = vim.fn.fnamemodify(self.filename, ":.")
		if filename == "" then
			return "[No Name]"
		end
		return " " .. filename .. " "
	end,
	on_click = {
		callback = function()
			vim.cmd("Telescope find_files")
		end,
		name = "find_files",
	},
	hl = { fg = colors.text, bg = colors.file_info },
}
local FileType = {
	provider = function()
		return string.upper(vim.bo.filetype)
	end,
	hl = { fg = utils.get_highlight("Type").fg, bg = colors.file_info, bold = true },
}
FileExt = utils.insert(FileBlock, FileIcon, FileType)
local FileFlags = {
	{
		condition = function()
			return vim.bo.modified
		end,
		provider = " ",
		hl = { fg = colors.text, bg = colors.file_info },
	},
	{
		condition = function()
			return not vim.bo.modifiable or vim.bo.readonly
		end,
		provider = " ",
		hl = { fg = colors.text, bg = colors.file_info },
	},
}

FileNameBlock = utils.insert(FileBlock, FileIcon, utils.insert(FileName, FileFlags))

-- Full nerd (with icon colors and clickable elements)!
-- works in multi window, but does not support flexible components (yet ...)
local Navic = {
	condition = function()
		return require("nvim-navic").is_available()
	end,
	static = {
		-- create a type highlight map
		type_hl = {
			File = "Directory",
			Module = "@include",
			Namespace = "@namespace",
			Package = "@include",
			Class = "@structure",
			Method = "@method",
			Property = "@property",
			Field = "@field",
			Constructor = "@constructor",
			Enum = "@field",
			Interface = "@type",
			Function = "@function",
			Variable = "@variable",
			Constant = "@constant",
			String = "@string",
			Number = "@number",
			Boolean = "@boolean",
			Array = "@field",
			Object = "@type",
			Key = "@keyword",
			Null = "@comment",
			EnumMember = "@field",
			Struct = "@structure",
			Event = "@keyword",
			Operator = "@operator",
			TypeParameter = "@type",
		},
		-- bit operation dark magic, see below...
		enc = function(line, col, winnr)
			return bit.bor(bit.lshift(line, 16), bit.lshift(col, 6), winnr)
		end,
		-- line: 16 bit (65535); col: 10 bit (1023); winnr: 6 bit (63)
		dec = function(c)
			local line = bit.rshift(c, 16)
			local col = bit.band(bit.rshift(c, 6), 1023)
			local winnr = bit.band(c, 63)
			return line, col, winnr
		end,
	},
	init = function(self)
		local data = require("nvim-navic").get_data() or {}
		local children = {}
		-- create a child for each level
		for i, d in ipairs(data) do
			-- encode line and column numbers into a single integer
			local pos = self.enc(d.scope.start.line, d.scope.start.character, self.winnr)
			local child = {
				{
					provider = d.icon,
					hl = self.type_hl[d.type],
				},
				{
					-- escape `%`s (elixir) and buggy default separators
					provider = d.name:gsub("%%", "%%%%"):gsub("%s*->%s*", ""),
					-- highlight icon only or location name as well
					-- hl = self.type_hl[d.type],

					on_click = {
						-- pass the encoded position through minwid
						minwid = pos,
						callback = function(_, minwid)
							-- decode
							local line, col, winnr = self.dec(minwid)
							vim.api.nvim_win_set_cursor(vim.fn.win_getid(winnr), { line, col })
						end,
						name = "heirline_navic",
					},
				},
			}
			-- add a separator only if needed
			if #data > 1 and i < #data then
				table.insert(child, {
					provider = " > ",
					hl = { fg = "#2a9d8f" },
				})
			end
			table.insert(children, child)
		end
		-- instantiate the new child, overwriting the previous one
		self.child = self:new(children, 1)
	end,
	-- evaluate the children containing navic components
	provider = function(self)
		return self.child:eval()
	end,
	hl = { fg = "gray" },
	update = "CursorMoved",
}
local align = { provider = "%=" }
local spacer = { provider = " " }

heirline.setup({
	-- statusline = {
	-- 	static = {
	-- 		filetypes = filetypes,
	-- 		buftypes = buftypes,
	-- 		force_inactive_filetypes = force_inactive_filetypes,
	-- 	},
	-- 	condition = function(self)
	-- 		return not conditions.buffer_matches({
	-- 			filetype = self.force_inactive_filetypes,
	-- 		})
	-- 	end,
	-- 	StatusLine.VimMode,
	-- 	StatusLine.Git,
	-- 	FileNameBlock,
	-- 	align,
	-- 	StatusLine.LSPActive,
	-- 	FileExt,
	-- 	StatusLine.FileEncoding,
	-- 	StatusLine.Diagnostics,
	-- 	StatusLine.Ruler,
	-- 	StatusLine.ScrollBar,
	-- },
	winbar = {
		{
			condition = function()
				return conditions.buffer_matches({
					buftype = { "nofile", "prompt", "help", "quickfix" },
					filetype = { "alpha", "oil", "toggleterm" },
				})
			end,
			init = function()
				vim.opt_local.winbar = nil
			end,
		},
		Navic,
	},
})
