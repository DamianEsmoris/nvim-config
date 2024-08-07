local commands = require 'myconf.myplugins.runcode'

for _,command in pairs(commands) do
	vim.api.nvim_create_user_command(command["name"], command["callback"], command["args"])
end
