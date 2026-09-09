return {
    "coder/claudecode.nvim",
    config = true,
    opts = {
        terminal = {
            provider = "none", -- No terminal management inside nvim
        },
    },
    -- `cmd` lets lazy.nvim create command stubs that load the plugin on first use,
    -- so `:ClaudeCode` and friends work on a fresh start. Without it, a keys-only
    -- spec defers loading until a <leader>a* mapping is pressed and the commands
    -- would not exist yet.
    cmd = {
        "ClaudeCode",
        "ClaudeCodeSelectModel",
        "ClaudeCodeAdd",
        "ClaudeCodeSend",
        "ClaudeCodeDiffAccept",
        "ClaudeCodeDiffDeny",
        "ClaudeCodeCloseAllDiffs",
    },
    keys = {
        { "<leader>ac", "<cmd>ClaudeCode<cr>",            desc = "Toggle Claude" },
        { "<leader>ar", "<cmd>ClaudeCode --resume<cr>",   desc = "Resume Claude" },
        { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
        { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
        { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",       desc = "Add current buffer" },
        { "<leader>as", "<cmd>ClaudeCodeSend<cr>",        mode = "v",                  desc = "Send to Claude" },
        -- Diff management
        { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>",  desc = "Accept diff" },
        { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",    desc = "Deny diff" },
    },
}
