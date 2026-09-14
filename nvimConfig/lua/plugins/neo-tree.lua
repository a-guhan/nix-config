return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",

	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
	},

	opts = {
		close_if_last_window = true,

		filesystem = {
			hijack_netrw_behavior = "disabled",

			filtered_items = {
				hide_dotfiles = false,
			},

			follow_current_file = {
				enabled = true,
			},
		},

		window = {
			position = "left",
			width = 30,
		},

		enable_title_bar = false,
		source_selector = {
			winbar = false,
			statusline = false,
		},
	},
}
