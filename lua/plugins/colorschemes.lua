return {
	{ "ellisonleao/gruvbox.nvim" },
	{
		"craftzdog/solarized-osaka.nvim",
		config = function()
			require("solarized-osaka").setup({
				transparent = false,
			})
			vim.cmd.colorscheme("solarized-osaka")
		end,
	},
	{ "rose-pine/neovim", name = "rose-pine" },
}
