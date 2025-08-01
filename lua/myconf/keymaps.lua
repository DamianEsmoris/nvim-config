function normal_mode(keymap, action, opts)
  opts = opts or {}
  vim.keymap.set("n", keymap, action, opts)
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
normal_mode("<C-l>", "<C-w>2>")
normal_mode("<C-h>", "<C-w>2<")

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

-- LSP
local opts = {buffer = bufnr, remap = false}
normal_mode("gd", function() vim.lsp.buf.definition() end, opts)
normal_mode("K", function() vim.lsp.buf.hover() end, opts)
normal_mode("<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
normal_mode("<leader>vd", function() vim.diagnostic.open_float() end, opts)
normal_mode("[d", function() vim.diagnostic.goto_next() end, opts)
normal_mode("]d", function() vim.diagnostic.goto_prev() end, opts)
normal_mode("<leader>vca", function() vim.lsp.buf.code_action() end, opts)
normal_mode("<leader>vrr", function() vim.lsp.buf.references() end, opts)
normal_mode("<leader>vrn", function() vim.lsp.buf.rename() end, opts)
normal_mode("<C-h>", function() vim.lsp.buf.signature_help() end, opts)
