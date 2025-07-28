-- Set leader to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Always account for line wraps
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

-- 0 always goes to first non-whitespace
 vim.keymap.set('n', '0', '_')

 -- Easily split windows
vim.keymap.set("n", "<leader>wv", ":vsplit<cr>", { desc = "[W]indow Split [V]ertical" })
vim.keymap.set("n", "<leader>wh", ":split<cr>", { desc = "[W]indow Split [H]orizontal" })
