return {
	{
		"nvimdev/lspsaga.nvim",
		event = "LspAttach",
		config = function()
			require("lspsaga").setup({
				lightbulb = {
					enable = false, -- Maintain your original setting
				},
				-- Add any other lspsaga configurations here
			})
		end,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"neovim/nvim-lspconfig", -- Ensure LSP config is available
		},
	},
}
