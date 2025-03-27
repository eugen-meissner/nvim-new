return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup({
			update_focused_file = {
				enable = true,
				update_cwd = true,
			},
			view = {
				width = 30,
				adaptive_size = true,
				side = "left",
			},
		})
	end,
}
