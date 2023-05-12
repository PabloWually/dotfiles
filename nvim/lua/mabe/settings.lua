local opt = vim.opt
vim.g.mapleader = ' '
-- line numbers
opt.relativenumber = true
opt.number = true

-- tabs and indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = false
opt.autoindent = true
opt.smartindent = true

--line wrapping
opt.wrap = false

--searching setting
opt.ignorecase = true
opt.smartcase = true

--cursor line
opt.cursorline = true
opt.cursorlineopt = "screenline,number"

--appearance
opt.background = "dark"
opt.termguicolors = true
opt.signcolumn = "yes"

opt.mouse = 'a'
opt.fillchars = {
  fold = " ",
  foldopen = "",
  foldclose = "",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
--backspace
opt.backspace = "indent,eol,start"

--clipboard
opt.clipboard:append("unnamedplus")

-- split windows
opt.splitright = true
opt.splitbelow = true

opt.iskeyword:append("-")

opt.signcolumn = 'yes'
opt.backup = false
opt.errorbells = false
opt.swapfile = false

opt.hlsearch = false
opt.breakindent = true
opt.updatetime = 300

-- Folding
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldcolumn = "1" -- Show the fold column
opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
opt.foldlevelstart = 99
opt.foldenable = true

opt.laststatus = 3 -- Use global statusline
opt.modelines = 1 -- Only use folding settings for this file
opt.sessionoptions = "buffers,curdir,folds,globals,tabpages,winpos,winsize" -- Session options to store in the session
opt.scrolloff = 3 -- Set the cursor 5 lines down instead of directly at the top of the file

opt.textwidth = 120 -- Total allowed width on the screen
opt.timeout = true -- This option and 'timeoutlen' determine the behavior when part of a mapped key sequence has been received. This is on by default but being explicit!
opt.timeoutlen = 900 -- Time in milliseconds to wait for a mapped sequence to complete.
opt.ttimeoutlen = 10 -- Time in milliseconds to wait for a key code sequence to complete
opt.updatetime = 100 -- If in this many milliseconds nothing is typed, the swap file will be written to disk. Also used for CursorHold autocommand and set to 100 as per https://github.com/antoinemadec/FixCursorHold.nvim

vim.wo.colorcolumn = "80,120"
vim.wo.list = true
vim.wo.numberwidth = 2
vim.wo.wrap = false
