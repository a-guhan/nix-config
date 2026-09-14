return {
	"nvim-lualine/lualine.nvim",

	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	opts = {
		options = {
			theme = "auto",
			globalstatus = true,
		},

		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch" },
			lualine_c = {
				{
					"filename",
					path = 1,
					file_status = true,
					newfile_status = true,
					symbols = {
						modified = " ●",
						readonly = " ",
					},
				},
			},
			lualine_x = {},
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
	},
}
