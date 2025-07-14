return {
	"stevearc/overseer.nvim",
	config = function()
		local overseer = require("overseer")

		overseer.setup({
			strategy = {
				"toggleterm",
				direction = "float",
				close_on_exit = false,
			},
			task_list = {
				direction = "float",
				bindings = {
					["q"] = function()
						vim.cmd("q")
					end,
				},
			},
		})

		-- Register custom tasks
		overseer.register_template({
			name = "Build Project",
			builder = function()
				return {
					cmd = { "dotnet" },
					args = { "build" },
					name = "dotnet build",
					components = {
						"default",
						"on_output_quickfix",
						{ "on_complete_notify", statuses = { "FAILURE", "SUCCESS" } },
					},
				}
			end,
			priority = 50,
		})

		overseer.register_template({
			name = "Test Project",
			builder = function()
				return {
					cmd = { "dotnet" },
					args = { "test" },
					name = "dotnet test",
					components = {
						"default",
						"on_output_quickfix",
						{ "on_complete_notify", statuses = { "FAILURE", "SUCCESS" } },
					},
				}
			end,
			priority = 50,
		})

		-- Key mappings for custom tasks
		vim.api.nvim_set_keymap(
			"n",
			"<leader>tb",
			[[<cmd>lua require("overseer").run_template({ name = "Build Project" })<CR>]],
			{ noremap = true, silent = true, desc = "Build Project" }
		)

		vim.api.nvim_set_keymap(
			"n",
			"<leader>tr",
			[[<cmd>lua require("overseer").run_template({ name = "Test Project" })<CR>]],
			{ noremap = true, silent = true, desc = "Test Project" }
		)
	end,
}
