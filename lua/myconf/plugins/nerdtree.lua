return {
  'nvim-tree/nvim-tree.lua',
  config = function()
    require('nvim-tree').setup()

    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    api = require 'nvim-tree.api'

    normal_mode('<leader>b', api.tree.toggle)
  end
}
