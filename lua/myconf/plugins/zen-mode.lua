return {
  {
    "folke/zen-mode.nvim",
    config = function()
      require "zen-mode".setup {
        window = {
          width = 90,
          options = {
            number = true,
            relativenumber = true
          }
        }
      };

			normal_mode("<leader>zz", ":ZenMode<CR>")
    end
  }
}
