-- Enhance % to be used to match words also
-- Modern version of matchit.vim
return {
    "andymass/vim-matchup",
    init = function()
        require("match-up").setup({})
    end,
}
