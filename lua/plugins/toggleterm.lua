return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			size = 20,
			open_mapping = [[<c-\>]],
			hide_numbers = true,
			shade_filetypes = {},
			shade_terminals = true,
			shading_factor = 2,
			start_in_insert = true,
			insert_mappings = true,
			persist_size = true,
			direction = "float",
			close_on_exit = true,
			shell = vim.o.shell,
			float_opts = {
				border = "curved",
				winblend = 0,
				highlights = {
					border = "Normal",
					background = "Normal",
				},
			},
		})

		-- Terminal keymappings
		function _G.set_terminal_keymaps()
			local opts = { noremap = true }
			vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
			vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
			vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
			vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
			vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
			vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
		end

		-- Auto command to set terminal keymaps when terminal opens
		vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

		-- Custom terminal functions
		local Terminal = require("toggleterm.terminal").Terminal

		-- Lazygit terminal
		local lazygit = Terminal:new({
			cmd = "lazygit",
			hidden = true,
			direction = "float",
			float_opts = {
				border = "curved",
			},
		})

		function _G.toggle_lazygit()
			lazygit:toggle()
		end

		-- Node terminal
		local node = Terminal:new({ cmd = "node", hidden = true })
		function _G.toggle_node()
			node:toggle()
		end

		-- Python terminal
		local python = Terminal:new({ cmd = "python", hidden = true })
		function _G.toggle_python()
			python:toggle()
		end

		-- Key mappings for custom terminals
		vim.api.nvim_set_keymap(
			"n",
			"<leader>tg",
			"<cmd>lua toggle_lazygit()<CR>",
			{ noremap = true, silent = true, desc = "Lazygit" }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>tn",
			"<cmd>lua toggle_node()<CR>",
			{ noremap = true, silent = true, desc = "Node" }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>tp",
			"<cmd>lua toggle_python()<CR>",
			{ noremap = true, silent = true, desc = "Python" }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>tt",
			"<cmd>ToggleTerm direction=float<CR>",
			{ noremap = true, silent = true, desc = "Float" }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>th",
			"<cmd>ToggleTerm size=15 direction=horizontal<CR>",
			{ noremap = true, silent = true, desc = "Horizontal" }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>tv",
			"<cmd>ToggleTerm size=80 direction=vertical<CR>",
			{ noremap = true, silent = true, desc = "Vertical" }
		)
	end,
}
