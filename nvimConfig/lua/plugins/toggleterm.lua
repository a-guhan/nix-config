return {
	"akinsho/toggleterm.nvim",
	version = "*",
	lazy = false,

	keys = {
		{
			"<leader>ot",
			"<cmd>ToggleTerm direction=float<CR>",
			desc = "Floating terminal",
		},
	},

	opts = {
		open_mapping = [[<C-\>]],
		direction = "float",
		start_in_insert = true,
		insert_mappings = true,
		terminal_mappings = true,
		persist_size = false,
		close_on_exit = true,
		autochdir = true,
		shade_terminals = false,

		float_opts = {
			border = "rounded",
			width = function()
				return math.floor(vim.o.columns * 0.8)
			end,
			height = function()
				return math.floor(vim.o.lines * 0.75)
			end,
			title = " Terminal ",
			title_pos = "center",
			winblend = 0,
		},
	},
}
