-- local jdtls_group = vim.api.nvim_create_augroup("jdtls_lsp", { clear = true })

-- -- Start/attach JDTLS when opening Java files
-- vim.api.nvim_create_autocmd("FileType", {
    -- group = jdtls_group,
    -- pattern = "java",
    -- callback = function()
        -- require('config.jdtls').setup_jdtls()
    -- end,
-- })

