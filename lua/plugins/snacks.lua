return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		bigfile = { enabled = false },
		dashboard = {
			enabled = true,
			sections = {
				-- {
				-- 	section = "terminal",
				-- 	cmd = "sh ~/.config/nvim/lua/utils/solair.sh",
				-- 	height = 25,
				-- 	pane = 2,
				-- 	padding = 1,
				-- },
				{
					pane = 1,
					{ title = "Projects", section = "projects", indent = 2, padding = 1 },
					{ section = "keys", gap = 1, padding = 10 },
					{ section = "startup" },
				},
			},
		},
		explorer = { enabled = false },
		indent = { enabled = false },
		input = { enabled = false },
		picker = { enabled = false },
		notifier = { enabled = true },
		quickfile = { enabled = false },
		scope = { enabled = false },
		scroll = { enabled = false },
		statuscolumn = { enabled = false },
		words = { enabled = false },
	},
}
