return {
	{ "ellisonleao/gruvbox.nvim" },
	{
		"craftzdog/solarized-osaka.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("solarized-osaka").setup({
				transparent = false,
			})
			vim.cmd.colorscheme("solarized-osaka")
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = function()
			require("gruvbox").setup({
				-- contrast = "hard",
				transparent_mode = false,
			})
		end,
	},
	{ "rose-pine/neovim", name = "rose-pine" },
	{
		"scottmckendry/cyberdream.nvim",
		lazy = false,
		priority = 1000,
		config = function() end,
	},
	{
		"xero/miasma.nvim",
		lazy = false,
		priority = 1000,
		config = function() end,
	},
}
