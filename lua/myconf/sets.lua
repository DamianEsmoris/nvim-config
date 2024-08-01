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
opt.tabstop = 2;
opt.shiftwidth = 2;
opt.softtabstop = 2;
opt.wrap = true;

-- netrtw 
g.netrw_winsize = 25;
g.netrtw_keepdir = 0; -- this creates files in netrw's current directory
