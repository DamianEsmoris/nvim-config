local function copy_table(t)
  local u = { }
  for k, v in pairs(t) do u[k] = v end
  return u
end

local function concat_arr(t1, t2)
	local u = copy_table(t1)
	for _, v in pairs(t2) do table.insert(u, v) end
	return u
end

commands = require 'myconf.myplugins.runcode'
commands = concat_arr(commands, require 'myconf.myplugins.fing-qol')

for _,command in pairs(commands) do
	vim.api.nvim_create_user_command(command["name"], command["callback"], command["args"])
end
