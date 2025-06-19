return {
	{
		"neovim/nvim-lspconfig",
		event = "VeryLazy",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			{ "j-hui/fidget.nvim", opts = {} },
			"Hoffs/omnisharp-extended-lsp.nvim",
		},
		config = function()
			-- Setup mason
			require("mason").setup()
			local mason_lspconfig = require("mason-lspconfig")
			mason_lspconfig.setup({
				automatic_installation = false,
			})

			-- Capabilities for autocompletion
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

			-- Setup installed servers
			for _, server_name in ipairs(mason_lspconfig.get_installed_servers()) do
				if server_name ~= "rust_analyzer" then
					lspconfig[server_name].setup({
						capabilities = capabilities,
					})
				end
			end
		end,
	},
}
