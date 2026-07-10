local opt = vim.opt; local g = vim.g;

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
opt.colorcolumn='80'


-- Windours
is_stinky_windows = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1
if is_stinky_windows then
  local powershell_cmd = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell"

  vim.opt_local.fileformat = "unix"
  vim.o.shell = powershell_cmd
  vim.o.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
  vim.o.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
  vim.o.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
  vim.o.shellquote = ""
  vim.o.shellxquote = ""
end
