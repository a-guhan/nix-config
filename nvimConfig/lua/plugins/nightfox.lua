return {
	"EdenEast/nightfox.nvim",
	priority = 1000,
	lazy = false,

	opts = {
		options = {
			transparent = true,
			terminal_colors = true,
			dim_inactive = false,

			styles = {
				comments = "italic",
				keywords = "bold",
				types = "italic",
			},
		},
	},

	config = function(_, opts)
		require("nightfox").setup(opts)
		vim.cmd.colorscheme("nightfox")
	end,
}
