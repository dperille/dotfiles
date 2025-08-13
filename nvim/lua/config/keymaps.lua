-- Set leader to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Always account for line wraps
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

-- 0 always goes to first non-whitespace
vim.keymap.set('n', '0', '_')

-- Leader-p from visual mode will delete into black-hole register, preserving what was in default yank register
vim.keymap.set("v", "<leader>p", "\"_dP", { desc = "Put, preserving default register" })

-- Manage windows
vim.keymap.set("n", "<leader>wv", ":vsplit<CR>", { desc = "[W]indow Split [V]ertical" })
vim.keymap.set("n", "<leader>ws", ":split<CR>", { desc = "[W]indow [S]plit Horizontal" })

vim.keymap.set("n", "<leader>wc", ":winc c<CR>", { desc = "[W]indow [C]lose" })
vim.keymap.set('n', '<leader>wn', ":winc n<CR>", { desc = "[W]indow [N]ew empty" })
vim.keymap.set('n', '<leader>wp', ":winc p<CR>", { desc = "[W]indow [P]revious" })

vim.keymap.set('n', '<leader>wh', ":winc h<CR>", { desc = "Move cursor to window left" })
vim.keymap.set('n', '<leader>wj', ":winc j<CR>", { desc = "Move cursor to window below" })
vim.keymap.set('n', '<leader>wk', ":winc k<CR>", { desc = "Move cursor to window above" })
vim.keymap.set('n', '<leader>wl', ":winc l<CR>", { desc = "Move cursor to window right" })

vim.keymap.set('n', '<leader>w>', ":winc ><CR>", { desc = "[W]indow increase width" })
vim.keymap.set('n', '<leader>w<', ":winc <<CR>", { desc = "[W]indow decrease width" })
vim.keymap.set('n', '<leader>w+', ":winc +<CR>", { desc = "[W]indow increase height" })
vim.keymap.set('n', '<leader>w-', ":winc -<CR>", { desc = "[W]indow decrease height" })
