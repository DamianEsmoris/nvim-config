return {
    "metalelf0/jellybeans-nvim",
		dependencies = {
			{ "rktjmp/lush.nvim" },
		},
    config = function()
				vim.cmd [[ colorscheme jellybeans-nvim]] 
				for _,v in pairs {"Normal", "NormalFloat", "NonText"} do
					vim.api.nvim_set_hl(0, v, { bg = "none" })
				end
    end
}
