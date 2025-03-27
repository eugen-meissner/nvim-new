return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		dependencies = {
			"echasnovski/mini.icons",
		},
		config = function()
			local wk = require("which-key")

			wk.setup({
				plugins = {
					marks = true,
					registers = true,
					spelling = {
						enabled = true,
						suggestions = 20,
					},
					presets = {
						operators = false,
						motions = true,
						text_objects = true,
						windows = true,
						nav = true,
						z = true,
						g = true,
					},
				},
				layout = {
					height = { min = 4, max = 25 },
					triggers_blacklist = {
						i = { "j", "k" }, -- Disable in insert mode
						v = { "j", "k" }, -- Disable in visual mode
					},
					width = { min = 20, max = 50 },
					spacing = 3,
					align = "left",
				},
				show_help = true,
				show_keys = false,
				triggers = { "<leader>", "<space>" },
				timeout = 10,
				disable = {
					buftypes = {},
					filetypes = { "TelescopePrompt" },
				},
			})

			-- Normal mode mappings
			wk.add({
				{ "<leader>d", "<cmd>DogeGenerate<cr>", desc = "Generate Docs" },

				{ "<leader>F", "<cmd>Telescope live_grep theme=ivy<cr>", desc = "Find Text" },
				{ "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
				{ "<leader>n", "<cmd>enew<cr>", desc = "New File" },

				{ "<leader>h", "<cmd>nohlsearch<CR>", desc = "No Highlight" },
				{ "<leader>k", "<cmd>TransparentToggle<CR>", desc = "Toggle Transparency" },
				{ "<leader>l", '<cmd>exec &bg=="light"? "set bg=dark" : "set bg=light"<CR>', desc = "Toggle Theme" },

				{ "<leader>p", "<cmd>lua require('telescope').extensions.projects.projects()<cr>", desc = "Projects" },

				{ "<leader>t", "<cmd>ToggleTerm direction=tab<cr>", desc = "Terminal (Root)" },
				{ "<leader>T", "<cmd>ToggleTerm direction=tab<cr>", desc = "Terminal (cwd)" },

				{ "<leader>g", "<cmd>Neogit<cr>", desc = "Status" },

				{ "<leader>b", "<cmd>lua require('telescope.builtin').buffers()<cr>", desc = "Switch Buffer" },
				{ "<leader>x", "<cmd>bdelete!<cr>", desc = "Delete Buffer" },
				{ "<leader>o", "<cmd>%bd|e#<cr>", desc = "Close Other Buffers" },

				{ "<leader>c", group = "code" },
				{ "<leader>ca", "<cmd>Lspsaga code_action<cr>", desc = "Code Action" },

				{ "<leader>r", group = "test" },

				{ "<leader>w", group = "window" },
				{ "<leader>wD", "<C-w>o", desc = "Close Others" },
				{ "<leader>wd", "<C-w>c", desc = "Close Window" },
				{ "<leader>wh", "<C-w>s", desc = "Horizontal Split" },
				{ "<leader>wm", "<C-w>_", desc = "Maximize Window" },
				{ "<leader>wr", "<C-w>r", desc = "Rotate Windows" },
				{ "<leader>wv", "<C-w>v", desc = "Vertical Split" },
			})
		end,
	},
	{
		"echasnovski/mini.icons",
		config = function()
			require("mini.icons").setup()
		end,
	},
}
