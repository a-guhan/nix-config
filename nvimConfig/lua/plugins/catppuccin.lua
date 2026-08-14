return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	lazy = false,

	opts = {
		flavour = "mocha",
		transparent_background = true,
		term_colors = true,
		dim_inactive = {
			enabled = false,
		},

		styles = {
			comments = { "italic" },
			keywords = { "bold" },
			types = { "italic" },
		},

		integrations = {
			treesitter = true,
			native_lsp = { enabled = true },
			telescope = true,
			fzf = true,
			neotree = true,
		},
	},

	config = function(_, opts)
		require("catppuccin").setup(opts)
		vim.cmd.colorscheme("catppuccin")
	end,
}
