return {
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		config = function()
			require("dashboard").setup({
				project = {
					enable = true,
					label = "Recent Projects",
					action = "Telescope find_files",
					detection_method = "auto",
				},
			})
		end,
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
}
