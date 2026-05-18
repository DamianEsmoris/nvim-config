return {
  'preservim/nerdtree',
  config = function()
    normal_mode('<leader>b', function()
      vim.cmd('NERDTreeToggle')
    end)
  end
}
