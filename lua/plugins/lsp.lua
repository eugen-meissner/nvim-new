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
			require("mason").setup()

			local mason_lspconfig = require("mason-lspconfig")
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			mason_lspconfig.setup({
				automatic_installation = false,
			})

			local omnisharp_extended = require("omnisharp_extended")

			-- Setup installed servers except 'omnisharp'
			for _, server_name in ipairs(mason_lspconfig.get_installed_servers()) do
				if server_name ~= "rust_analyzer" and server_name ~= "omnisharp" then
					lspconfig[server_name].setup({
						capabilities = capabilities,
					})
				end
			end

			-- Manual setup for omnisharp with extended support
			lspconfig.omnisharp.setup({
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					omnisharp_extended.on_attach(client, bufnr)
					-- Optional keymaps for LSP actions
				end,
				cmd = {
					"omnisharp", -- make sure this is in PATH, or give full path
					"--languageserver",
					"--hostPID",
					tostring(vim.fn.getpid()),
				},
			})
		end,
	},
}
