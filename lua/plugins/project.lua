return {
	{
		"ahmedkhalf/project.nvim",
		event = "VimEnter",
		config = function()
			require("project_nvim").setup({
				active = true,
				manual_mode = false,
				detection_methods = { "pattern" },
				patterns = { ".git" },
				show_hidden = false,
				silent_chdir = true,
				ignore_lsp = {},
				datapath = vim.fn.stdpath("data"),
			})

			-- Load telescope extension after setup
			pcall(function()
				require("telescope").load_extension("projects")
			end)
		end,
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
	},
	-- Add this if you don't already have telescope configured elsewhere
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
}
