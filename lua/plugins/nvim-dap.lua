return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			{
				"stevearc/overseer.nvim",
				opts = {},
			},
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			-- Configure what terminal to use when external terminal is requested
			dap.defaults.fallback.external_terminal = {
				command = "/usr/bin/alacritty",
				args = { "-e" },
			}
			-- LLDB
			dap.adapters.lldb = {
				type = "executable",
				command = "codelldb",
				name = "lldb",
			}
			-- Setup the dotnet debugger
			dap.adapters.coreclr = {
				type = "executable",
				command = "netcoredbg",
				args = { "--interpreter=vscode" },
			}
			-- Go
			dap.adapters.delve = function(callback, config)
				if config.mode == "remote" and config.request == "attach" then
					callback({
						type = "server",
						host = config.host or "127.0.0.1",
						port = config.port or "38697",
					})
				else
					callback({
						type = "server",
						port = "${port}",
						executable = {
							command = "dlv",
							args = { "dap", "-l", "127.0.0.1:${port}", "--log", "--log-output=dap" },
							detached = vim.fn.has("win32") == 0,
						},
					})
				end
			end
			dap.configurations.go = {
				{
					type = "delve",
					name = "Debug",
					request = "launch",
					program = "${file}",
				},
				{
					type = "delve",
					name = "Debug test", -- configuration for debugging test files
					request = "launch",
					mode = "test",
					program = "${file}",
				},
				-- works with go.mod packages and sub packages
				{
					type = "delve",
					name = "Debug test (go.mod)",
					request = "launch",
					mode = "test",
					program = "./${relativeFileDirname}",
				},
			}
			-- Customize the dap ui
			dapui.setup({
				icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
				controls = {
					icons = {
						pause = "⏸",
						play = "▶",
						step_into = "⏎",
						step_over = "⏭",
						step_out = "⏮",
						step_back = "b",
						run_last = "▶▶",
						terminate = "⏹",
						disconnect = "⏏",
					},
				},
				layouts = {
					{
						elements = {
							-- Elements can be strings or table with id and size keys.
							{ id = "scopes", size = 0.25 },
							"breakpoints",
							"stacks",
							"watches",
						},
						size = 60, -- 60 columns
						position = "left",
					},
					{
						elements = {
							"repl",
							"console",
						},
						size = 0.25, -- 25% of total lines
						position = "bottom",
					},
				},
				floating = {
					max_height = nil, -- These can be integers or nil.
					max_width = nil, -- Integers if greater than 1, float if less than 1
					border = "single", -- Border style. Can be "single", "double" or "rounded"
					mappings = {
						close = { "q", "<Esc>" },
					},
				},
				windows = { indent = 1 },
				render = {
					max_type_length = nil, -- Can be integer or nil.
					max_value_lines = 100, -- Can be integer or nil.
				},
			})
			-- Register listeners
			dap.listeners.after.event_initialized["dapui_config"] = dapui.open
			dap.listeners.before.event_terminated["dapui_config"] = dapui.close
			dap.listeners.before.event_exited["dapui_config"] = dapui.close
			-- Process launch.json and tasks.json files
			require("overseer").setup({
				task_list = {
					direction = "bottom",
					min_height = 25,
					max_height = 25,
					default_detail = 1,
				},
				form = {
					border = "rounded",
					zindex = 40,
					min_width = 80,
					max_width = 0.9,
					width = nil,
					min_height = 10,
					max_height = 0.9,
					height = nil,
					win_opts = {
						winblend = 10,
					},
				},
				confirm = {
					border = "rounded",
					zindex = 40,
					min_width = 80,
					width = nil,
					max_width = 0.5,
					min_height = 10,
					height = nil,
					max_height = 0.9,
					win_opts = {
						winblend = 10,
					},
				},
				task_win = {
					padding = 1,
					border = "rounded",
					win_opts = {
						winblend = 10,
					},
				},
			})

			require("dap.ext.vscode").json_decode = require("overseer.json").decode
			require("dap.ext.vscode").load_launchjs(
				nil,
				{ codelldb = { "rust" }, lldb = { "rust" }, coreclr = { "cs" } }
			)

			-- Add build feedback for debugging
			local function show_build_progress()
				vim.notify("🔨 Building application...", vim.log.levels.INFO, { title = "Debug Build" })
				-- Open overseer task list in floating window
				vim.cmd("OverseerOpen!")
			end

			local function hide_build_progress()
				vim.notify("✅ Build completed successfully!", vim.log.levels.INFO, { title = "Debug Build" })
				-- Close overseer immediately when build is done
				vim.cmd("OverseerClose")
			end

			-- Hook into DAP events to show build progress
			dap.listeners.before.event_initialized["build_feedback"] = function()
				-- This runs when debugging starts (after build)
				hide_build_progress()
			end

			-- Override the run function to show build feedback only after profile selection
			local original_run = dap.run
			dap.run = function(config, opts)
				-- Show build progress only when a config is actually selected and run
				if config and config.preLaunchTask then
					show_build_progress()
				end
				original_run(config, opts)
			end

			-- Override continue to handle first-time runs differently
			local original_continue = dap.continue
			dap.continue = function()
				local session = dap.session()
				if not session then
					-- This is a new debug session, let the user select a profile first
					-- The build feedback will be shown in dap.run when a profile is selected
					original_continue()
				else
					-- This is continuing an existing session
					original_continue()
				end
			end
		end,
	},
}
