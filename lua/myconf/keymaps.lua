-- Helper functions to map keys in different modes
function normal_mode(keymap, action)
  vim.keymap.set("n", keymap, action)
end

function visual_mode(keymap, action)
  vim.keymap.set("v", keymap, action)
end

-- Explorer
normal_mode("<leader>b", ":Lexplore<CR>")

-- Buffers
normal_mode("<leader>y", '"*y')
normal_mode("<leader>p", '"*p')
normal_mode("<leader>d", '"_d')

-- Exit term mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- Custom commands
normal_mode("<F5>", ":RunWholeFile<CR>")
visual_mode("<F5>", ":RunSnippet<CR>")
