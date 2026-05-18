return {
    "chikko80/error-lens.nvim",
    dependencies = { 'nvim-telescope/telescope.nvim' },
    event = "BufRead",
    config = function()
        require("error-lens").setup({
            enabled = true,
            auto_adjust = {
                enable = false,
            },
        })
    end
}
