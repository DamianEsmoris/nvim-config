local opt = vim.opt;
local g = vim.g;

g.mapleader = ',';

-- Background issues
--	(in Alacritty the background wasn't transparent, this poc changes it)
for _,v in pairs {"Normal", "NormalFloat", "NonText"} do
	vim.api.nvim_set_hl(0, v, { bg = "none" })
end

-- Line numbers
opt.number = true;
opt.relativenumber = true;

-- QoL
opt.tabstop = 4;
opt.shiftwidth = 4;
opt.softtabstop = 4;
opt.expandtab = true;
opt.wrap = true;

-- netrtw 
g.netrw_winsize = 25;
g.netrtw_keepdir = 0; -- this creates files in netrw's current directory
