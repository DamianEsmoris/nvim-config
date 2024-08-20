local function copy_table(t)
  local u = { } for k, v in pairs(t) do u[k] = v end
  return setmetatable(u, getmetatable(t))
end

local function concat_table_w_keys(t1,t2)
	local new_table = copy_table(t1)
	for key,value in pairs(t2) do new_table[key] = value end
	return new_table
end

local commands = {}
commands = concat_table_w_keys(commands, require 'myconf.myplugins.runcode')
commands = concat_table_w_keys(commands, require 'myconf.myplugins.fing-qol')

for _,command in pairs(commands) do
	vim.api.nvim_create_user_command(command["name"], command["callback"], command["args"])
end
