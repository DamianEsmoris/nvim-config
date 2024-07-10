return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },


		config = function()
			require 'telescope'.setup {
			 defaults = { 
					file_ignore_patterns = { 
						"node_modules",
						"target" 
					}
				}
			};


			local builtin = require 'telescope.builtin';

			normal_mode("<leader>F", builtin.find_files, {});
			normal_mode("<leader>fg", builtin.live_grep, {});
			normal_mode("<leader>fb", builtin.buffers, {});
			normal_mode("<leader>fh", builtin.help_tags, {});
		end

}
