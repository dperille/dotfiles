---- Searching behavior
-- Case-insensitive unless search includes upper-case
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Highlight all search results
vim.opt.hlsearch = true

-- Jumps to result as you type, not after enter
vim.opt.incsearch = true


---- Left column & similar settings
-- Show absolute number on current line & relative for all others
vim.opt.number = true
vim.opt.relativenumber = true

-- Set width of line number column
vim.opt.numberwidth = 2

-- Always show sign column
vim.opt.signcolumn = "yes"

-- Number of lines to keep above/below cursor
vim.opt.scrolloff = 10

-- Number of columns to keep to the left/right of cursor
vim.opt.sidescrolloff = 8

-- Highlight current line
vim.opt.cursorline = true

-- Display line as single line
vim.opt.wrap = false


---- Tab spacing behavior
-- Use spaces instead of tabs
vim.opt.expandtab = true

-- Use 4 spaces for each indentation level
vim.opt.shiftwidth = 4

-- Use 4 spaces for each tab character
vim.opt.tabstop = 4

-- Enable smart indent
vim.opt.smartindent = true

-- Use the indent from the previous line
vim.opt.autoindent = true


---- Misc
vim.opt.termguicolors = true

-- Sync clipboard between OS and Neovim -- scheduled after `UiEnter` because it can increase startup-time
vim.schedule(function()
    vim.o.clipboard = 'unnamedplus'
end)

-- If performing an operation that would fail due to unsaved changes in the buffer (like `:q`), instead raise a dialog asking if you wish to save the current file(s)
vim.o.confirm = true
