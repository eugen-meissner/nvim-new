return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "┃" },
					change = { text = "┃" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "┆" },
				},
				signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
				numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
				linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
				word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
				watch_gitdir = {
					follow_files = true,
				},
				auto_attach = true,
				attach_to_untracked = false,
				current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
					delay = 500,
					ignore_whitespace = false,
					virt_text_priority = 100,
					virt_text_format = function(blame)
						if blame.author == "Not Committed Yet" then
							return { { " • Uncommitted changes", "GitSignsCurrentLineBlame" } }
						end

						local author = blame.author
						if #author > 15 then
							author = author:sub(1, 12) .. "..."
						end

						return {
							{ " • ", "GitSignsCurrentLineBlame" },
							{ author, "GitSignsCurrentLineBlame" },
							{ " • ", "GitSignsCurrentLineBlame" },
							{
								blame.author_time and os.date("%Y-%m-%d", blame.author_time) or "",
								"GitSignsCurrentLineBlame",
							},
							{ " • ", "GitSignsCurrentLineBlame" },
							{ blame.summary or "", "GitSignsCurrentLineBlame" },
						}
					end,
				},
				current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
				sign_priority = 6,
				update_debounce = 100,
				status_formatter = nil, -- Use default
				max_file_length = 40000, -- Disable if file is longer than this (in lines)
				preview_config = {
					-- Options passed to nvim_open_win
					border = "single",
					style = "minimal",
					relative = "cursor",
					row = 0,
					col = 1,
				},
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation
					map("n", "]c", function()
						if vim.wo.diff then
							return "]c"
						end
						vim.schedule(function()
							gs.next_hunk()
						end)
						return "<Ignore>"
					end, { expr = true, desc = "Next hunk" })

					map("n", "[c", function()
						if vim.wo.diff then
							return "[c"
						end
						vim.schedule(function()
							gs.prev_hunk()
						end)
						return "<Ignore>"
					end, { expr = true, desc = "Previous hunk" })

					-- Actions
					map("n", "<leader>gb", gs.toggle_current_line_blame, { desc = "Toggle Git Blame" })
					map("n", "<leader>gB", function()
						gs.blame_line({ full = true })
					end, { desc = "Git Blame Line (Full)" })
					map("n", "<leader>gd", gs.diffthis, { desc = "Git Diff" })
					map("n", "<leader>gD", function()
						gs.diffthis("~")
					end, { desc = "Git Diff (cached)" })
					map("n", "<leader>gr", gs.reset_hunk, { desc = "Reset Hunk" })
					map("n", "<leader>gR", gs.reset_buffer, { desc = "Reset Buffer" })
					map("n", "<leader>gs", gs.stage_hunk, { desc = "Stage Hunk" })
					map("n", "<leader>gS", gs.stage_buffer, { desc = "Stage Buffer" })
					map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })
					map("n", "<leader>gp", gs.preview_hunk, { desc = "Preview Hunk" })

					-- Text object
					map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
				end,
			})
		end,
	},
}
