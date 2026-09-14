return {
	"vague-theme/vague.nvim",
	lazy = false,
	priority = 1001,
	opts = {
		transparent = false,
	},
	config = function()
		vim.cmd.colorscheme("vague")
	end,
}
