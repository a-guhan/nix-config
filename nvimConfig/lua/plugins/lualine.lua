return {
	"nvim-lualine/lualine.nvim",

	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	opts = {
		options = {
			theme = "nightfox",
			globalstatus = true,
		},

		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch" },
			lualine_c = {},
			lualine_x = {},
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},

		winbar = {
			lualine_a = {
				{
					"filename",
					path = 0,
					file_status = true,
					newfile_status = true,
					symbols = {
						modified = " ●",
						readonly = " ",
					},
					color = {
						gui = "bold",
					},
				},
			},
		},
	},
}
