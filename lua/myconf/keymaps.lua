-- Helper functions to map keys in different modes
function normal_mode(keymap, action)
  vim.keymap.set("n", keymap, action)
end

function visual_mode(keymap, action)
  vim.keymap.set("v", keymap, action)
end

function normal_and_visual_mode(keymap, action)
	normal_mode(keymap, action)
	visual_mode(keymap, action)
end

-- Splits
normal_mode("<C-k>", "<C-w>2-")
normal_mode("<C-j>", "<C-w>2+")

-- Explorer
normal_mode("<leader>b", ":Lexplore<CR>")

-- Buffers
visual_mode("<leader>y", '"+y')
normal_and_visual_mode("<leader>p", '"+p')
normal_and_visual_mode("<leader>d", '"_d')

-- Exit term mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- Custom commands
normal_mode("<F5>", ":RunWholeFile<CR>")
normal_mode("<F8>", ":TestWholeFile<CR>")
visual_mode("<F5>", ":RunSnippet<CR>")
