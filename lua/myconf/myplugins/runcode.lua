local langs = require "myconf.myplugins.langs";

local function copy_table(t)
  local u = { }
  for k, v in pairs(t) do u[k] = v end
  return setmetatable(u, getmetatable(t))
end

local function concat_table_w_keys(t1,t2)
	local new_table = copy_table(t1)
	for key,value in pairs(t2) do new_table[key] = value end
	return new_table
end

local function get_selected_lines()
  local vstart = vim.fn.getpos("'<")
  local vend = vim.fn.getpos("'>")
  return table.concat(vim.fn.getline(vstart[2], vend[2]), "\n")
end

local function remove_file_extension(file)
	return file:gsub("%.(.+)$", "") or file
end

local function replace_cmd_placeholders(cmd, file)
	local filename = remove_file_extension(file)
	return cmd:gsub("_filename", filename):gsub("_file", file)
end

local function write_tmp_snippet_file(content)
	local tmpfile = vim.fn.tempname()
	local f = io.open(tmpfile, "w")
	f:write(content)
	f:close()
	return tmpfile
end

return {
	{
		name="RunSnippet",
		callback=function()
			local lang_cmd = langs["interpreted"][vim.bo.filetype]
			if lang_cmd ~= nil then
				local lines = get_selected_lines()

				if lines == "" then
					print("No text selected.")
					return
				end

				local tmpfile = write_tmp_snippet_file(lines)
				lang_cmd = replace_cmd_placeholders(lang_cmd, tmpfile)
				vim.api.nvim_command(":!" .. lang_cmd)
			else
				print("No interpreter language found for the current file type.")
			end
		end,
		args={ nargs = '*', range = true, desc = 'Run an interpreted language snippet of code' }
	},

	{
		name="RunWholeFile",
		callback=function()
			local langs_union = concat_table_w_keys(langs["compiled"], langs["interpreted"])
			local lang_cmd = langs_union[vim.bo.filetype]
			if lang_cmd ~= nil then
				local file = vim.api.nvim_buf_get_name(0)
				lang_cmd = replace_cmd_placeholders(lang_cmd, file)
				vim.api.nvim_command(":!" .. lang_cmd)
			else
				print("No compiler/interpreter found for the current file type.")
			end
		end,
		args={ nargs = '*', desc = 'Run the whole file' }
	}
}
