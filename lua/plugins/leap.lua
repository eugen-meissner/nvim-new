return {
	"ggandor/leap.nvim",
	dependencies = { "tpope/vim-repeat" },
	config = function()
		local leap = require("leap")

		-- Setup leap
		leap.setup({
			case_sensitive = false,
			-- You can customize other leap settings here if needed
		})

		-- Set up keymaps for 't' and 'T'
		vim.keymap.set({ "n", "x", "o" }, "t", function()
			leap.leap({ target_windows = { vim.fn.win_getid() } })
		end, { desc = "Leap forward" })

		vim.keymap.set({ "n", "x", "o" }, "T", function()
			leap.leap({ target_windows = { vim.fn.win_getid() }, backward = true })
		end, { desc = "Leap backward" })

		-- Disable the default leap keybindings
		-- This is important since we're using custom keys
		leap.opts.safe_labels = {}
	end,
}
