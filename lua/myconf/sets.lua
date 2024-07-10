local opt = vim.opt;
local g = vim.g;

g.mapleader = ',';

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
