vim.cmd.packadd("packer.nvim")

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- *************************** UI ***************************************
	-- Themes
	use({ "catppuccin/nvim", as = "catppuccin" })
	use("olimorris/onedarkpro.nvim")
	use("EdenEast/nightfox.nvim")

	-- Home View
	use({
		"goolord/alpha-nvim",
	})

	-- Status bar
	use("feline-nvim/feline.nvim")
	use({ "lewis6991/gitsigns.nvim" })
	use("rebelot/heirline.nvim")

	-- icons
	use("nvim-tree/nvim-web-devicons")

	-- Inden guide lines
	use("lukas-reineke/indent-blankline.nvim")

	-- Rainbow parentheses
	use("p00f/nvim-ts-rainbow")

	-- Colorizer
	use("norcalli/nvim-colorizer.lua")
	-- Highlighter
	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })

	-- Dressing
	use("stevearc/dressing.nvim")

	-- ************************** FINDING ***********************************
	-- fuzzi findind
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "make",
		requires = {
			"junegunn/fzf.vim",
			requires = {
				{
					"tpope/vim-dispatch",
					cmd = { "Make", "Dispatch" },
				},
			},
		},
	})
	use({
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-file-browser.nvim" },
			{ "nvim-telescope/telescope-ui-select.nvim" },
		},
	})
	use({
		"nvim-telescope/telescope-frecency.nvim",
		requires = { "kkharji/sqlite.lua" },
	})
	-- Mapping
	use({
		"mrjones2014/legendary.nvim",
		requires = "kkharji/sqlite.lua",
	})

	-- ************************* LSP ****************************************
	-- LSP server
	use({
		"VonHeikemen/lsp-zero.nvim",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },          -- Required
			{ "williamboman/mason.nvim" },        -- Optional
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional
			{
				"SmiteshP/nvim-navic",
				require("nvim-navic").setup({
					highlight = true,
					separator = "  ",
				}),
			},
			-- Null-ls
			{
				"jose-elias-alvarez/null-ls.nvim", -- General purpose LSP server for running linters, formatters, etc
			},
			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },      -- Required
			{ "hrsh7th/cmp-nvim-lsp" },  -- Required
			{ "hrsh7th/cmp-buffer" },    -- Optional
			{ "hrsh7th/cmp-path" },      -- Optional
			{ "saadparwaiz1/cmp_luasnip" }, -- Optional
			{ "hrsh7th/cmp-nvim-lua" },  -- Optional

			-- Snippets
			{ "L3MON4D3/LuaSnip" },          -- Required
			{ "saadparwaiz1/cmp_luasnip" },  -- for Autocompletion
			{ "rafamadriz/friendly-snippets" }, -- Optional
		},
	})

	-- ***************************** File Navigator *************************
	-- tmux & split windows navigator
	use("christoomey/vim-tmux-navigator")

	-- file explore
	use("nvim-tree/nvim-tree.lua")
	use("szw/vim-maximizer")
	use("ThePrimeagen/harpoon")

	-- ***************************** Autocompletion *************************
	-- essential plugins
	use("tpope/vim-surround")

	-- commenting with gc
	use("numToStr/Comment.nvim")

	--autoclosing
	use("windwp/nvim-autopairs")
	use("windwp/nvim-ts-autotag")
	use({ "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" })
	-- ***************************** Debugger *******************************
	use("mfussenegger/nvim-dap")

	-- ************************* Session management *************************
	use("olimorris/persisted.nvim")
end)
