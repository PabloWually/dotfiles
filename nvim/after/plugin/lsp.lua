-- Reserve space for diagnostic icons

local lsp = require("lsp-zero")
lsp.preset("recommended")

require("legendary").commands({
	{
		":Mason",
		description = "Open Mason",
	},
	{
		":MasonUninstallAll",
		description = "Uninstall all Mason packages",
	},
})
require("legendary").keymaps({
	itemgroup = "Completion",
	icon = "",
	description = "Completion related functionality...",
	keymaps = {
		{
			"<Enter>",
			description = "Confirms selection",
		},
		{
			"<Up>",
			description = "Go to previous item on the list",
		},
		{
			"<Down>",
			description = "Go to next item on the list",
		},
		{
			"<Ctrl-e>",
			description = "Toggle completion menu",
		},
		{
			"<Ctrl-h>",
			description = "Go to previous placeholder in snippet",
		},
		{
			"<Ctrl-l>",
			description = "Go to next placeholder in snippet",
		},
		{
			"<Tab>",
			description = "Enable completion when inside a word OR go to next item",
		},
		{
			"<S-Tab>",
			description = "Go to previous item",
		},
	},
})

lsp.set_preferences({
	set_lsp_keymaps = false,
	sign_icons = {
		error = " ",
		warn = " ",
		hint = " ",
		info = " ",
	},
})

lsp.ensure_installed({
	-- Replace these with whatever servers you want to install
	"bashls",
	"cssls",
	"dockerls",
	"html",
	"intelephense",
	"jdtls",
	"jsonls",
	"lua_ls",
	"pyright",
	-- "tailwindcss", -- Disabled due to high node CPU usage
	"tsserver",
	"vuels",
	"yamlls",
})

lsp.skip_server_setup({ "jdtls" })

lsp.set_server_config({
	capabilities = {
		textDocument = {
			foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			},
		},
	},
})

lsp.nvim_workspace()

local function autocmds(client, bufnr)
	require("legendary").autocmds({
		{
			name = "LspOnAttachAutocmds",
			clear = false,
			{
				{ "CursorHold", "CursorHoldI" },
				":silent! lua vim.lsp.buf.document_highlight()",
				opts = { buffer = bufnr },
			},
			{
				"CursorMoved",
				":silent! lua vim.lsp.buf.clear_references()",
				opts = { buffer = bufnr },
			},
		},
	})
end

local function commands(client, bufnr)
	-- Only need to set these once!
	if vim.g.lsp_commands then
		return {}
	end

	require("legendary").commands({
		{
			":LspRestart",
			description = "Restart any attached clients",
		},
		{
			":LspStart",
			description = "Start the client manually",
		},
		{
			":LspInfo",
			description = "Show attached clients",
		},
		{
			"LspInstallAll",
			function()
				for _, name in pairs(om.lsp.servers) do
					vim.cmd("LspInstall " .. name)
				end
			end,
			description = "Install all servers",
		},
		{
			"LspUninstallAll",
			description = "Uninstall all servers",
		},
		{
			"LspLog",
			function()
				vim.cmd("edit " .. vim.lsp.get_log_path())
			end,
			description = "Show logs",
		},
		{
			"NullLsInstall",
			description = "null-ls: Install plugins",
		},
	})

	vim.g.lsp_commands = true
end

local function mappings(client, bufnr)
	if
			#vim.tbl_filter(function(keymap)
				return (keymap.desc or ""):lower() == "rename symbol"
			end, vim.api.nvim_buf_get_keymap(bufnr, "n")) > 0
	then
		return
	end

	local t = require("legendary.toolbox")

	require("legendary").keymaps({
		itemgroup = "LSP",
		icon = "",
		description = "LSP related functionality",
		keymaps = {
			{
				"<Leader>f",
				"<cmd>LspZeroFormat<CR>",
				description = "Format document",
				mode = { "n", "v" },
			},
			{
				"gf",
				t.lazy_required_fn("telescope.builtin", "diagnostics", {
					layout_strategy = "center",
					bufnr = 0,
				}),
				description = "Find diagnostics",
			},
			{ "gd", vim.lsp.buf.definition,      description = "Go to definition",      opts = { buffer = bufnr } },
			{ "gi", vim.lsp.buf.implementation,  description = "Go to implementation",  opts = { buffer = bufnr } },
			{ "gt", vim.lsp.buf.type_definition, description = "Go to type definition", opts = { buffer = bufnr } },
			{
				"gr",
				t.lazy_required_fn("telescope.builtin", "lsp_references", {
					layout_strategy = "center",
				}),
				description = "Find references",
				opts = { buffer = bufnr },
			},
			{
				"gl",
				"<cmd>lua vim.diagnostic.open_float(0, { border = 'single', source = 'always' })<CR>",
				description = "Line diagnostics",
				opts = { buffer = bufnr },
			},
			{
				"K",
				vim.lsp.buf.hover,
				description = "Show hover information",
				opts = { buffer = bufnr },
			},
			{
				"<Leader>p",
				t.lazy_required_fn("nvim-treesitter.textobjects.lsp_interop", "peek_definition_code", "@block.outer"),
				description = "Peek definition",
				opts = { buffer = bufnr },
			},
			{
				"ga",
				vim.lsp.buf.code_action,
				description = "Show code actions",
				opts = { buffer = bufnr },
			},
			{
				"gs",
				vim.lsp.buf.signature_help,
				description = "Show signature help",
				opts = { buffer = bufnr },
			},
			{
				"<Leader>rn",
				vim.lsp.buf.rename,
				description = "Rename symbol",
				opts = { buffer = bufnr },
			},
			{
				"[",
				vim.diagnostic.goto_prev,
				description = "Go to previous diagnostic item",
				opts = { buffer = bufnr },
			},
			{ "]", vim.diagnostic.goto_next, description = "Go to next diagnostic item", opts = { buffer = bufnr } },
		},
	})
end

lsp.on_attach(function(client, bufnr)
	autocmds(client, bufnr)
	commands(client, bufnr)
	mappings(client, bufnr)

	if client.server_capabilities.documentSymbolProvider then
		require("nvim-navic").attach(client, bufnr)
	end
end)

local null_ls = require("null-ls")
local null_opts = lsp.build_options("null-ls", {})

null_ls.setup({
	on_attach = function(client, bufnr)
		null_opts.on_attach(client, bufnr)

		require("legendary").commands({
			{
				":NullFormat",
				function()
					vim.lsp.buf.format({
						id = client.id,
						timeout_ms = 5000,
						async = true,
					})
				end,
				hide = true,
				description = "null-ls: format buffer",
			},
		})
	end,
	debounce = 150,
	sources = {
		-- Code completion
		null_ls.builtins.code_actions.eslint_d,

		-- Formatting
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.fish_indent,
		null_ls.builtins.formatting.fixjson,
		null_ls.builtins.formatting.google_java_format,
		null_ls.builtins.formatting.isort,
		null_ls.builtins.formatting.phpcsfixer,
		null_ls.builtins.formatting.prettier.with({
			filetypes = {
				"css",
				"dockerfile",
				"html",
				"javascript",
				"json",
				"markdown",
				"vue",
				"yaml",
			},
		}),
		null_ls.builtins.formatting.shfmt.with({
			filetypes = { "sh", "zsh" },
		}),
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.xmllint,
	},
})

-- Setup better folding
local ok, ufo = pcall(require, "ufo")
if ok then
	require("ufo").setup()
end

-- Configure lua language server for neovim
lsp.setup()
