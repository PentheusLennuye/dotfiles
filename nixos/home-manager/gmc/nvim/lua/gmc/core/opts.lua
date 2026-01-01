-- [[ opts.lua ]]

-- Allow the built-in neovim file explorer use the "tree" style
vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

-- [[ Context ]]
-- colorcolumn highlights a column to remind programmers to be readable
opt.colorcolumn = "100"

-- cursorline highlights the cursor y-position for easier location and focus
opt.cursorline = true

-- number displays the absolute line number
opt.number = true
opt.scrolloff = 4

-- signColumn gives a three-character left margin to prevent text-shift on warnings
opt.signcolumn = "yes"


-- [[ Filetypes ]]
opt.encoding = "utf8"
opt.fileencoding = "utf8"


-- [[ Theme ]]
-- background is a toggle to colour schemes with dark/light modes
opt.background = "dark"
-- opt.syntax = "ON"
-- opt.termguicolors = true


-- [[ Search ]]
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = false


-- [[ Whitespace ]]
-- autoindent copies the indent from the current line
opt.autoindent = true

-- backspace allows backspaces on indents, etc
opt.backspace = "indent,eol,start"

-- expandtab converts tabs into spaces. Do not use for Makefiles
opt.expandtab = true

-- default width is 2 to save space, but will be changed per language standard
opt.shiftwidth = 2
opt.softtabstop = 2
opt.tabstop = 2


-- [[ Splits ]]
-- split* indicates where new windows are placed on the canvas
opt.splitright = true
opt.splitbelow = true


-- [[ System Integration ]]
-- clipboard permits the use of the system clipboard for cutting and pasting
opt.clipboard:append("unnamedplus")

