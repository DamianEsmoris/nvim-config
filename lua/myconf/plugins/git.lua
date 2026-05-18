return {
  "tpope/vim-fugitive",
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require 'gitsigns'.setup({
        on_attach = function ()
          local gitsigns = package.loaded.gitsigns

          visual_mode('<leader>ga', function()
            gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
          end)

          normal_mode('<leader>ga', gitsigns.stage_hunk)
        end
      })
    end
  }
}
